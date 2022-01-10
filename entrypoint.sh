#!/bin/sh -l

echo "Hello $1"
echo "Event Type: ${{ github.event_name }}"
time=$(date)
echo ::set-output name=time::$time