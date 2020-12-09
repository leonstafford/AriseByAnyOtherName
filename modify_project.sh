#!/bin/sh

# usage example 
#
#   sh modify_project renamespace ~/wp2staticguzzle GuzzleHttp WP2StaticGuzzleHttp

ACTION=$1
REPO_DIR=$2

ORIGINAL_NAMESPACE=''
NEW_NAMESPACE=''

ORIGINAL_USER=''
ORIGINAL_REPO=''
NEW_USER=''
NEW_REPO=''

TEMPLATE=''

if [ "$ACTION" = "renamespace" ]
then

  echo "given an input namespace, output namespace and a directory,"
  echo "it rewrites all instances within the dir matching our pattern."

  ORIGINAL_NAMESPACE=$3
  NEW_NAMESPACE=$4


  grep -Rl "$ORIGINAL_NAMESPACE" "$REPO_DIR" | xargs gsed -i \
    "s/$ORIGINAL_NAMESPACE/$NEW_NAMESPACE/g"

elif [ "$ACTION" = "changeuserrepo" ]
then

  echo "given an input repo user/name, output repo user/name and dir,"
  echo "will do bulk rewrites of that exact match in composer.json"
  echo "$ORIGINAL_USER"
  echo "$ORIGINAL_REPO"
  echo "$NEW_USER"
  echo "$NEW_REPO"

elif [ "$ACTION" = "applytemplate" ]
then

  echo "This allows me to publish my rewritten fork to Packagist"
  echo ""
  echo "given an input local filename, like './templates/deletions/guzzle'"
  echo "and input dir, will remove all files/dirs from the repo that are"
  echo "specified in my template"
else

  echo "Unknown command, should print out usage"

  echo "$TEMPLATE"
fi



