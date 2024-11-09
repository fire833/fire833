#!/bin/bash

echo "System environment variables: "
echo
printenv
echo

function sourceCreds() {
    [[ $1 == "1" ]] && echo "Attempting to source credentials from /etc/grafana/creds/creds.env..."
    [[ -f "/etc/grafana/creds/creds.env" ]] && source /etc/grafana/creds/creds.env || return 1
    return 0
}

sourceCreds 0
res="$?"

if [[ $FORCE_SOURCE_DB_CREDS == 1 ]]; then
    while [[ $res == "1" ]]; do
        sourceCreds 1
        res="$?"
        sleep 5
    done
fi

echo "Starting server (args: $@)..."
[[ -f "/run.sh" ]] && /run.sh "$@" || echo "entrypoint /run.sh not found, exiting..." && false
