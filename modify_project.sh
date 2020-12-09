#!/bin/sh

ACTION=$1
REPO_DIR=$2

ORIGINAL_NAMESPACE=''
NEW_NAMESPACE=''

ORIGINAL_USER=''
ORIGINAL_REPO=''
NEW_USER=''
NEW_REPO=''

if [ "$ACTION" = "renamespace" ]
then

  echo "given an input namespace, output namespace and a directory,"
  echo "it rewrites all instances within the dir matching our pattern."


elif [ "$ACTION" = "changeuserrepo" ]
then

  echo "given an input repo user/name, output repo user/name and dir,"
  echo "will do bulk rewrites of that exact match in composer.json"

elif [ "$ACTION" = "applytemplate" ]
then

  echo "This allows me to publish my rewritten fork to Packagist"
  echo ""
  echo "given an input local filename, like './templates/deletions/guzzle'"
  echo "and input dir, will remove all files/dirs from the repo that are"
  echo "specified in my template"
else

  echo "Unknown command, should print out usage"

fi



