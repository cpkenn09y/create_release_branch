#!/bin/bash

# colors START
red=$'\e[1;31m'
yellow=$'\e[1;33m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
green='\033[0;32m'
end=$'\e[0m'
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

echo "What is the name of the original release?"
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
echo -e "$green $COMMAND_CREATE_BRANCH $end "
echo ""
eval $COMMAND_CREATE_BRANCH

COMMAND_PUSH_BRANCH="git push origin $NEW_BRANCH_NAME"
echo -e "$green $COMMAND_PUSH_BRANCH $end "
echo ""
eval $COMMAND_PUSH_BRANCH

COMMAND_RETURN_TO_ORIGINAL_BRANCH="git checkout $ORIGINAL_BRANCH"
echo -e "$green $COMMAND_RETURN_TO_ORIGINAL_BRANCH $end "
echo ""
eval $COMMAND_RETURN_TO_ORIGINAL_BRANCH

COMMAND_DELETE_BRANCH="git branch -D $NEW_BRANCH_NAME"
echo -e "$green $COMMAND_DELETE_BRANCH $end "
echo ""
eval $COMMAND_DELETE_BRANCH

echo -e ""
echo -e "$green Successfully created release checkpoint!"
# Reset to original TZ
TZ=$ORIGINAL_TZ
