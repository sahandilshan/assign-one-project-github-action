#!/bin/sh -l

echo "Project URL: $INPUT_PROJECT" #$1
echo "Column: $INPUT_COLUMN_NAME" #$2
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

PROJECT_URL=INPUT_PROJECT
PROJECT_JSON=$(curl -i -u $GITHUB_ACTOR:$GITHUB_TOKEN --location --request GET "https://api.github.com/repos/$GITHUB_REPOSITORY/projects" \
--header 'Accept: application/vnd.github.v3+json')
PROJECT_ID=$(echo "$PROJECT_JSON" | jq -r ".[] | select(.html_url == \"$PROJECT_URL\").id")
echo "$PROJECT_JSON"
echo "========="
echo "$PROJECT_ID"



time=$(date)
echo ::set-output name=time::$time