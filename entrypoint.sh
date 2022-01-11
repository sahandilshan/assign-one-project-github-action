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
echo "Owner: $GITHUB_REPOSITORY"
ISSUE_ID=$(jq -r '.issue.id' < "$GITHUB_EVENT_PATH")
echo < "$GITHUB_EVENT_PATH"
echo "Issue Id: $ISSUE_ID"


ISSUE_JSON=$(curl -s -X GET -u $GITHUB_ACTOR:$GITHUB_TOKEN "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$ISSUE_ID" \
--header 'Accept: application/vnd.github.v3+json')


PROJECT_URL=$INPUT_PROJECT
COLUMN_NAME=$INPUT_COLUMN_NAME
PROJECT_JSON=$(curl -s -X GET -u $GITHUB_ACTOR:$GITHUB_TOKEN "https://api.github.com/repos/$GITHUB_REPOSITORY/projects" \
--header 'Accept: application/vnd.github.v3+json')
echo "Project URL: $PROJECT_URL"
PROJECT_ID=$(echo "$PROJECT_JSON" | jq -r ".[] | select(.html_url == \"$PROJECT_URL\").id")
echo "$PROJECT_JSON"
echo "========="
echo "$PROJECT_ID"

if [ -z "$PROJECT_ID" ]; then
    echo "Unable to retrieve project id, Please check the given project url [$PROJECT_URL]."
    exit 1
fi

COLUMNS_JSON=$(curl -s -X GET -u $GITHUB_ACTOR:$GITHUB_TOKEN "https://api.github.com/projects/$PROJECT_ID/columns" \
--header 'Accept: application/vnd.github.v3+json')
COLUMN_ID=$(echo "$COLUMNS_JSON" | jq -r ".[] | select(.name == \"$COLUMN_NAME\").id")

if [ -z "$COLUMN_ID" ]; then
    echo "Unable to retrieve column id, Please check the given column_name [$COLUMN_NAME]."
    exit 1
fi

# Add this issue to the project column
    curl -s -X POST -u "$GITHUB_ACTOR:$GITHUB_TOKEN" --retry 3 \
     -H 'Accept: application/vnd.github.v3+json' \
     -d "{\"content_type\": \"Issue\", \"content_id\": $ISSUE_ID}" \
     "https://api.github.com/projects/columns/$COLUMN_ID/cards"

time=$(date)
echo ::set-output name=time::$time