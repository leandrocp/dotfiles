# Sourced by the realtime:* mise tasks. Derives ports/node name so multiple
# git worktrees can run Realtime in parallel without colliding. On main it
# uses the default pink ports; elsewhere it derives unique values from the
# worktree directory and runs standalone (no clustering).
branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ "$branch" = "main" ]; then
  export NAME="pink"
  export PORT=4000
  export GEN_RPC_TCP_SERVER_PORT=5369
  export GEN_RPC_TCP_CLIENT_PORT=5469
else
  offset=$(( $(basename "$PWD" | cksum | cut -d' ' -f1) % 100 ))
  export NAME="realtime-${offset}"
  export PORT=$((4100 + offset))
  export GEN_RPC_TCP_SERVER_PORT=$((5600 + offset))
  export GEN_RPC_TCP_CLIENT_PORT=$((5700 + offset))
  export CLUSTER_STRATEGIES=""
fi
