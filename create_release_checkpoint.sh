#!/bin/bash

# colors START
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'
GREEN='\033[0;32m'
# colors END

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
echo ""
read -p "-> " RELEASE_NAME

# Storing original timezone
ORIGINAL_TZ=$TZ

SPECIAL_DATE_FORMAT=`date +Y%yM%mD%d`

# export TZ=America/New_York date
export TZ=America/Los_Angeles date

TIMESTAMP=`date +%Y%m%d%H%M%S`
SHORT_TIMESTAMP=`date +%Y%m%d`

NEW_BRANCH_NAME=$RELEASE_NAME-$ENVIRONMENT-$TIMESTAMP

ORIGINAL_BRANCH=`git rev-parse --abbrev-ref HEAD`


COMMAND_CREATE_BRANCH="git checkout -b $NEW_BRANCH_NAME"
echo -e "$GREEN $COMMAND_CREATE_BRANCH $end "
echo ""
eval $COMMAND_CREATE_BRANCH

COMMAND_PUSH_BRANCH="git push origin $NEW_BRANCH_NAME"
echo -e "$GREEN $COMMAND_PUSH_BRANCH $end "
echo ""
eval $COMMAND_PUSH_BRANCH

COMMAND_RETURN_TO_ORIGINAL_BRANCH="git checkout $ORIGINAL_BRANCH"
echo -e "$GREEN $COMMAND_RETURN_TO_ORIGINAL_BRANCH $end "
echo ""
eval $COMMAND_RETURN_TO_ORIGINAL_BRANCH

echo -e ""
echo -e "$GREEN Successfully created release checkpoint!"
# Reset to original TZ
TZ=$ORIGINAL_TZ
