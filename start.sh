#!/bin/bash

# Starte unattended-upgrades im Hintergrund
unattended-upgrades &

# Starte sls
exec /srt-live-server/bin/sls -c /srt-live-server/sls.conf
