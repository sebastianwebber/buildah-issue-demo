#!/bin/bash

. /build/my-app.conf

function log() {
    echo "$(date) [${APP_NAME}] "$*
}

log "hello ubi8-minimal - starting..."
log "I was set as version '${APP_VERSION}'!"

sleep 5

log "ok, i'm done."