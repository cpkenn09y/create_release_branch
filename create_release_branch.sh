#!/bin/bash

echo "1) QA "
echo "2) Staging"
echo "3) Production"
read -p "Please choose the server that you are releasing this branch to 1, 2 or 3: " ENVIRONMENT

case $ENVIRONMENT in
   1) ENVIRONMENT='QA'
   ;;
   2) ENVIRONMENT='Staging'
   ;;
   3) ENVIRONMENT='Production'
   ;;
esac

echo "What is the name of this release?"
echo "eg. 20160928-ReleaseV1.1.1"
read -p " " RELEASE_NAME

# Storing original timezone
ORIGINAL_TZ=$TZ

SPECIAL_DATE_FORMAT=`date +Y%yM%mD%d`

# export TZ=America/New_York date
export TZ=America/Los_Angeles date

TIMESTAMP=`date +%Y%m%d%H%M%S`
SHORT_TIMESTAMP=`date +%Y%m%d`

NEW_BRANCH_NAME=$SHORT_TIMESTAMP-$RELEASE_NAME-$ENVIRONMENT-$TIMESTAMP

COMMAND_CREATE_BRANCH="git checkout -b $NEW_BRANCH_NAME"

eval $COMMAND_CREATE_BRANCH

COMMAND_PUSH_BRANCH="git push origin $NEW_BRANCH_NAME"

eval $COMMAND_PUSH_BRANCH

# Reset to original TZ
TZ=$ORIGINAL_TZ
