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
echo "Owner: $GITHUB_REPOSITORY"

PROJECT_URL=$2
PROJECT_JSON=$(curl -i -u sahandilshan:$GITHUB_TOKEN --location --request GET 'https://api.github.com/repos/sahandilshan/sample-repo/projects' \
--header 'Accept: application/vnd.github.v3+json')
echo "$PROJECT_JSON"


time=$(date)
echo ::set-output name=time::$time