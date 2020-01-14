#!/bin/bash
# ============================================================
# title           : <name>.sh
# description     : Script to do something useful
# version         : v0.1
# ============================================================


# ============================================================
# how to... get some useful variables
# ------------------------------------------------------------
BASEDIR=$(dirname "$0")
echo "Script is running from folder $BASEDIR"

YYYYmmdd=$(date +%Y%m%d)
echo "Current date stamp $BASEDIR"


# ============================================================
# how to... script argument processing
# ------------------------------------------------------------
URL="https://google.com"
DATABASE="mysql.sql"
FLAG="NO"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
      -url)
      URL="$2"
      shift # past argument
      shift # past value
      ;;
      -db|--database)
      DATABASE="$2"
      shift # past argument
      shift # past value
      ;;
      -u|--user|--username)
      USERNAME="$2"
      shift # past argument
      shift # past value
      ;;
      -p|--pass|--password)
      PASSWORD="$2"
      shift # past argument
      shift # past value
      ;;
      --flag)
      FLAG=YES
      shift # past argument
      ;;
      *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

echo "url: $URL"
echo "database: "$DATABASE
echo "flag: "$FLAG
echo

# ============================================================
# how to... if elif fi statements
# -lt less than
# -le less than or equal to
# -gt greater than
# -ge greater than or equal to
# -eq equal to
# -ne not equal to
# ------------------------------------------------------------
if [ "$USERNAME" = "" ] && [ "$PASSWORD" = "" ]
then
   echo "please specify a --username and --password value"
elif [ "$USERNAME" -ne "" ] && [ "$PASSWORD" = "" ]
then
   echo "please specify a --password value"
elif [ "$USERNAME" = "" ] && [ "$PASSWORD" -ne "" ]
then
   echo "please specify a --username value"
else
   echo "$USERNAME/$PASSWORD"
fi


# ============================================================
# how to... pause for keyboard entry
# ------------------------------------------------------------
read -p "Press [Enter] key to continue this script..."


# ============================================================
# how to... echo multiline string
# ------------------------------------------------------------
WP_DATABASE_RESET="wp db reset --yes"
WP_DATABASE_IMPORT="wp db import ../$DATABASE"
WP_SEARCH_REPLACE_HTTPS="wp search-replace https://admin.peievents.com https://$URL --url=https://admin.peievents.com"
WP_SEARCH_REPLACE_ROOT="wp search-replace admin.peievents.com $URL --all-tables --report-changed-only"
WP_CREATE_ADMIN_USER="wp user create $USERNAME $ADMIN_EMAIL --user_pass=$PASSWORD --role=administrator"
WP_CREATE_SUPER_USER="wp super-admin add $USERNAME"

# create a new executable shell script to be executed by user...
export SCRIPTFILE="./temp.sh"

echo "#!/bin/bash
# move into public folder where wp commands should be executed from
cd public
echo Running... $WP_DATABASE_RESET
echo Running... $WP_DATABASE_IMPORT
echo Running... $WP_SEARCH_REPLACE_HTTPS
echo Running... $WP_SEARCH_REPLACE_ROOT
echo Running $WP_CREATE_ADMIN_USER
echo Running $WP_CREATE_SUPER_USER
echo Finished
" > $SCRIPTFILE

chmod 777 $SCRIPTFILE

. $SCRIPTFILE
rm $SCRIPTFILE
