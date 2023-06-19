#!/bin/sh
set -e

if [ -f tmp/pids/server.pid ]; then
    rm tmp/pids/server.pid
fi

# echo "Running database migrations..."
bundle exec rails db:migrate 2>/dev/null || bundle exec rails db:create db:migrate
# echo "Finished running database migrations."

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec bundle exec "$@"
