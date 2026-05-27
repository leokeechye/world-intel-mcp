#!/usr/bin/env sh
# One image, two roles. Railway sets SERVICE_ROLE per service.
#   SERVICE_ROLE=collector -> 24/7 collector daemon (populates Qdrant)
#   anything else (default) -> Starlette+SSE dashboard, binds 0.0.0.0:$PORT
set -e

if [ "$SERVICE_ROLE" = "collector" ]; then
    exec intel-collector --daemon --interval "${COLLECT_INTERVAL:-300}"
else
    export HOST="${HOST:-0.0.0.0}"
    exec intel-dashboard
fi
