#!/bin/bash

echo "1) QA "
echo "2) Staging"
echo "3) Production"
read -p "Please choose the server that you are releasing this branch to 1, 2 or 3: " ENVIRONMENT

# if [ "$ENVIRONMENT" = '1' ];
#   then
#   ENVIRONMENT="QA"
# fi

# if [ "$ENVIRONMENT" = '2' ];
#   then
#   ENVIRONMENT="STAGING"
# fi

# if [ "$ENVIRONMENT" = '3' ];
#   then
#   ENVIRONMENT="PRODUCTION"
# fi

# echo $ENVIRONMENT

case $ENVIRONMENT in
   1) ENVIRONMENT='QA'
   ;;
   2) ENVIRONMENT='Staging'
   ;;
   3) ENVIRONMENT='Production'
   ;;
esac

echo $ENVIRONMENT

read -p "What is the version of the software? " VERSION

DATE=`date +Y%yM%mD%d`
RELEASE_PREFIX="ReleaseV"

COMMAND="git checkout -b $DATE-$RELEASE_PREFIX$VERSION-$ENVIRONMENT"

eval $COMMAND



