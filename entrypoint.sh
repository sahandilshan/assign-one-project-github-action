#!/bin/sh -l

echo "Hello $1"
echo "Event Type: $GITHUB_EVENT_NAME"
time=$(date)
echo ::set-output name=time::$time