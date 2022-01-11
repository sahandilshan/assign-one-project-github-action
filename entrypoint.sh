#!/bin/sh -l

echo "Hello $1"
echo "Event Type: $GITHUB_EVENT_NAME"
echo "Github Action: $GITHUB_ACTIONS"
echo "Github Action: $GITHUB_ACTION"
echo "Github Action Path: $GITHUB_ACTION_PATH"
echo "GitHub Token: $GITHUB_TOKEN"
echo "GitHub Actor: $GITHUB_ACTOR"
echo "GitHub Event Path $GITHUB_EVENT_PATH"
ISSUE_ID=$(jq -r '.issue.id' < "$GITHUB_EVENT_PATH")
echo "Issue Id: $ISSUE_ID"
time=$(date)
echo ::set-output name=time::$time