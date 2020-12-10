#!/bin/sh

# usage example 
#
#   Rewrite all namespaces in a project
#
#   sh modify_project.sh renamespace ~/wp2staticguzzle GuzzleHttp WP2StaticGuzzleHttp
#
#   sh modify_project.sh renamespace ~/wp2staticpromises GuzzleHttp WP2StaticGuzzleHttp
#
#   sh modify_project.sh renamespace ~/wp2staticpsr7 GuzzleHttp WP2StaticGuzzleHttp
#
#   Rewrite user/repo in composer.json
#
#   sh modify_project.sh  changeuserrepo ~/wp2staticguzzle \
#     'guzzlehttp/guzzle' 'leonstafford/wp2staticguzzle'
#
#   sh modify_project.sh  changeuserrepo ~/wp2staticpromises \
#     'guzzlehttp/promises' 'leonstafford/wp2staticpromises'
#
#   sh modify_project.sh  changeuserrepo ~/wp2staticpsr7 \
#     'guzzlehttp/psr7' 'leonstafford/wp2staticpsr7'
#
#   Apply transformations template to a project
#
#   sh modify_project.sh applytemplate ~/wp2staticguzzle wp2staticguzzle
#   sh modify_project.sh applytemplate ~/wp2staticpromises wp2staticpromises
#   sh modify_project.sh applytemplate ~/wp2staticpsr7 wp2staticpsr7

ACTION=$1
REPO_DIR=$2

ORIGINAL_NAMESPACE=''
NEW_NAMESPACE=''

ORIGINAL_USERREPO=''
NEW_USERREPO=''

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
  ORIGINAL_USERREPO=$3
  NEW_USERREPO=$4

  echo "given an input repo user/name, output repo user/name and dir,"
  echo "will do bulk rewrites of that exact match in composer.json"

  gsed -i "s|$ORIGINAL_USERREPO|$NEW_USERREPO|g" \
   "$REPO_DIR/composer.json" 
    

elif [ "$ACTION" = "applytemplate" ]
then

  echo "This allows me to publish my rewritten fork to Packagist"
  echo ""
  echo "given an input local filename, like './templates/deletions/guzzle'"
  echo "and input dir, will remove all files/dirs from the repo that are"
  echo "specified in my template"

  TEMPLATE=$3
  echo "$TEMPLATE"

  /bin/sh "./templates/$TEMPLATE.sh" "$REPO_DIR"
else

  echo "Unknown command, should print out usage"

fi



