#!/bin/bash

unattended-upgrades &

exec /srt-live-server/bin/sls -c /srt-live-server/sls.conf
