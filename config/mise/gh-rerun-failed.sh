#!/usr/bin/env bash
# Re-run failed jobs for GitHub Actions runs in a repo or on a PR.
#
# Mirrors the "Re-run failed jobs" button (gh run rerun <id> --failed): it only
# retries the jobs that failed, not the whole run.
#
# Usage:
#   gh-rerun-failed.sh [--repo OWNER/REPO] [--pr NUMBER] [--limit N] [--dry-run]
#
#   --repo   Target repo (default: repo of the current directory).
#   --pr     PR number/URL — only re-runs failed runs on that PR's head branch.
#   --limit  Max number of recent runs to scan (default: 50).
#   --dry-run  Print what would be re-run without triggering anything.
#
# Examples:
#   gh-rerun-failed.sh                       # all failed runs in current repo
#   gh-rerun-failed.sh --pr 33               # failed runs on PR #33
#   gh-rerun-failed.sh --repo supabase/realtime --pr 33
set -euo pipefail

repo=""
pr=""
limit=50
dry_run=false

while [ $# -gt 0 ]; do
	case "$1" in
	--repo)
		repo="$2"
		shift 2
		;;
	--pr)
		pr="$2"
		shift 2
		;;
	--limit)
		limit="$2"
		shift 2
		;;
	--dry-run)
		dry_run=true
		shift
		;;
	-h | --help)
		sed -n '2,20p' "$0" | sed 's/^# \{0,1\}//'
		exit 0
		;;
	*)
		echo "Unknown arg: $1" >&2
		exit 1
		;;
	esac
done

# Build args as flat strings (bash 3.2 on macOS chokes on empty-array + set -u).
list_args=(run list --limit "$limit")
[ -n "$repo" ] && list_args+=(--repo "$repo")

# Restrict to a PR's head branch if requested.
if [ -n "$pr" ]; then
	view_args=(pr view "$pr" --json headRefName -q .headRefName)
	[ -n "$repo" ] && view_args+=(--repo "$repo")
	branch=$(gh "${view_args[@]}")
	echo "PR #$pr -> branch '$branch'"
	list_args+=(--branch "$branch")
fi

# shellcheck disable=SC2054  # commas are gh's --json field separator, one argument
list_args+=(--json databaseId,status,conclusion,displayTitle,headBranch
	-q '.[] | select(.status == "completed" and (.conclusion == "failure" or .conclusion == "timed_out" or .conclusion == "cancelled")) | "\(.databaseId)\t\(.headBranch)\t\(.displayTitle)"')

# Collect failed (and timed-out) run IDs (read loop instead of mapfile for bash 3.2).
run_ids=()
while IFS= read -r line; do
	[ -n "$line" ] && run_ids+=("$line")
done < <(gh "${list_args[@]}")

if [ "${#run_ids[@]}" -eq 0 ]; then
	echo "No failed runs found."
	exit 0
fi

echo "Found ${#run_ids[@]} failed run(s):"
for line in "${run_ids[@]}"; do
	id=${line%%	*}
	rest=${line#*	}
	echo "  - $id  ($rest)"
done

for line in "${run_ids[@]}"; do
	id=${line%%	*}
	if [ "$dry_run" = true ]; then
		echo "[dry-run] gh run rerun $id --failed"
	else
		echo "Re-running failed jobs for run $id ..."
		rerun_args=(run rerun "$id" --failed)
		[ -n "$repo" ] && rerun_args+=(--repo "$repo")
		gh "${rerun_args[@]}" || echo "  ! failed to rerun $id (maybe too old or no failed jobs)" >&2
	fi
done
