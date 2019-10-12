#!/usr/bin/env sh

if [ -f "tmp/pids/server.pid" ]; then
  echo "Removing stale server.pid"
  rm tmp/pids/server.pid
fi

# Execute CMD
exec "$@"