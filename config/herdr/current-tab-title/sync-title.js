#!/usr/bin/env bun

import { spawnSync } from "node:child_process";

const herdr = process.env.HERDR_BIN_PATH || "herdr";

function run(args) {
	const result = spawnSync(herdr, args, {
		encoding: "utf8",
		stdio: ["ignore", "pipe", "pipe"],
	});

	if (result.status !== 0) {
		throw new Error(
			result.stderr || result.stdout || `herdr ${args.join(" ")} failed`,
		);
	}

	return result.stdout.trim();
}

function json(args) {
	const output = run(args);

	try {
		return JSON.parse(output);
	} catch {
		throw new Error(`herdr ${args.join(" ")} returned invalid JSON`);
	}
}

function clean(value) {
	return String(value ?? "")
		.replace(/[\x00-\x1f\x7f]/g, " ")
		.replace(/\s+/g, " ")
		.trim();
}

function currentTitle() {
	const pane = json(["pane", "current"])?.result?.pane;
	if (!pane) return "herdr";

	const tab = json(["tab", "get", pane.tab_id])?.result?.tab;
	const workspace = json(["workspace", "get", pane.workspace_id])?.result
		?.workspace;

	const tabName = clean(tab?.label) || clean(tab?.number) || clean(pane.tab_id);
	const workspaceName = clean(workspace?.label);
	const title = `tab ${tabName}`;

	return workspaceName ? `${title} (${workspaceName})` : title;
}

try {
	const title = currentTitle().slice(0, 80);
	run(["terminal", "title", "set", title]);
} catch (error) {
	console.error(error instanceof Error ? error.message : String(error));
	process.exit(1);
}
