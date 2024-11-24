#!/bin/bash
# ============================================================
# title           : <name>.sh
# description     : Script to do something useful
# version         : v0.1
# ============================================================
# Get the absolute path of the script
ABSOLUTE_BASEPATH=$(dirname "$(readlink -f "$0")")

echo "Script directory: $ABSOLUTE_BASEPATH"

# ============================================================
# how to... get some useful variables
# ------------------------------------------------------------
BASEDIR=$(dirname "$0")
echo "Script is running from folder $BASEDIR"

YYYYmmdd=$(date +%Y%m%d)
echo "Current date stamp $YYYYmmdd"

echo
echo "# arguments called with ---->  ${@}     "
echo "# \$1 ----------------------->  $1      "
echo "# \$2 ----------------------->  $2      "
echo "# path to me --------------->  ${0}     "
echo "# parent path -------------->  ${0%/*}  "
echo "# my name ------------------>  ${0##*/} "
echo

#
# help
#
function help {
  echo "try passing some arguments"
  echo
  echo "-url <url>"
  echo "-db|--database <database>"
  echo "-u|--user|--username <username>"
  echo "-p|--pass|--password <password>"
  echo "--flag"
  echo
  exit 0
}

if [ "$#" = 0 ]
then
  help
fi

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
echo "username: "$USERNAME
echo "password: "$PASSWORD
echo "flag: "$FLAG
echo


# ============================================================
# how to... check for directory or file
# -d directory
# -f file
# ! -d directory not found
# ! -f file not found
# ------------------------------------------------------------
if [ -d "." ]
then
   echo "yep, current directory exists"
fi

if [ ! -d "not-found" ]
then
   echo "nope, not-found directory doesn't exist"
fi


# ============================================================
# how to... check for matching regex
# [ "SOMETHING" =~ "regex" ]
# ------------------------------------------------------------
if [[ ["ABC" =~ "B"] ]]; then
  echo "ABC matches with B as a regex"
fi
if [[ "ABC.123" =~ [^a-zA-Z0-9-] ]]; then
  echo "ABC-123 contains matches [^a-zA-Z0-9-] as a regex and therefore has invalid char"
fi


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


# ============================================================
# how to... read specific character for prompts
# ------------------------------------------------------------
read -r -p "Do you want to do something [y/n]?" input
if [ "$input" = "y" ]; then
  echo "Do it now"
else
  echo "Do it later"
fi


# ============================================================
# how to... strip a url into domain
# ------------------------------------------------------------

function domain {
  echo "Checking   : $1"
  SITEURL=$1
  if [[ "$SITEURL" = "" ]] | [[ "${SITEURL}" =~ ERROR ]]; then
    echo "Suppressed : $SITEURL"
  else
    DOMAIN=${SITEURL/https:\/\//}
    DOMAIN=${DOMAIN/http:\/\//}
    echo $SITEURL was stripped into $DOMAIN
  fi
}

domain
domain https://www.google.com
domain http://www.google.com
domain "ERROR 1146 (42S02) at line 1: Table 'local.wp_8_options' doesn't exist"


# ============================================================
# how to... declare array
# ------------------------------------------------------------

array=(one two three four [5]=five)

echo "Array size: ${#array[*]}"

echo "Array items:"
for item in ${array[*]}
do
    printf "   %s\n" $item
done

echo "Array indexes:"
for index in ${!array[*]}
do
    printf "   %d\n" $index
done

echo "Array items and indexes:"
for index in ${!array[*]}
do
    printf "%4d: %s\n" $index ${array[$index]}
done

array=("first item" "second item" "third" "item")

echo "Number of items in original array: ${#array[*]}"
for ix in ${!array[*]}
do
    printf "   %s\n" "${array[$ix]}"
done
echo

arr=(${array[*]})
echo "After unquoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done
echo

arr=("${array[*]}")
echo "After * quoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done
echo

arr=("${array[@]}")
echo "After @ quoted expansion: ${#arr[*]}"
for ix in ${!arr[*]}
do
    printf "   %s\n" "${arr[$ix]}"
done

ARRAY=()
ARRAY+=('foo')
ARRAY+=('bar')

echo "Array items:"
for item in ${ARRAY[*]}
do
    printf "   %s\n" $item
done

. ./template-variables.sh

echo "Variable Values from External file template-variables.sh"
echo "TMP_VAR_NAME=$TMP_VAR_NAME"
echo "TMP_VAR_SCRIPTNAME=$TMP_VAR_SCRIPTNAME"
echo "TMP_VAR_VALUE=$TMP_VAR_VALUE"

#
# sed url parsing
#
URLPATHQUERY=$(echo 'http://admin.stage.domain.com/one/two/three/something?a=1&b=2' | sed 's|.*://[^/]*/\([^?]*\)|/\1|g')
echo URLPATHQUERY=$URLPATHQUERY
URLPATH=$(echo 'http://admin.stage.domain.com/one/two/three/something?a=1&b=2' | sed 's|.*://[^/]*/\([^?]*\)?.*|/\1|g')
echo URLPATH=$URLPATH
URLDOMAIN=$(echo 'http://admin.stage.domain.com/one/two/three/something?a=1&b=2' | sed -E -e 's_.*://([^/@]*@)?([^/:]+).*_\2_')
echo URLDOMAIN=$URLDOMAIN

echo "hello" > temp.log
echo "one" >> temp.log
echo "two" >> temp.log
echo "three" >> temp.log

#
# arrays
#

printf "\ncreate and loop through array"

ARRAY=( "cow moo"
        "dinosaur roar"
        "bird chirp"
        "bash rock" )

for animal in "${ARRAY[@]}" ; do
    KEY=${animal%% *}
    VALUE=${animal#* }
    printf "%s likes to %s.\n" "$KEY" "$VALUE"
done

printf "\nindex access array element\n"
echo -e "${ARRAY[1]%%:*} is an extinct animal which likes to ${ARRAY[1]#*:}\n"

printf "\nread array from file with eval\n"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'XYZ=($(cat ./template-map.txt))'
echo "XYZ[1]=${XYZ[1]}"

printf "\nread array from file with read command\n"
IFS=$'\n' read -d '' -r -a lines < ./template-map.txt
echo "lines[1]=${lines[1]}"

printf "\nloop through array values (lines from file)\n"
for line in "${lines[@]}" ; do
    KEY=${line%% *}
    VALUE=${line#* }
    printf "%s likes to %s.\n" "$KEY" "$VALUE"
done

keyarray
valarray
printf "\nloop through array indices (lines from file)\n"
for index in "${!lines[@]}"; do
    KEY=${lines[index]%% *}
    VALUE=${lines[index]#* }
    printf "%s likes to %s.\n" "$KEY" "$VALUE"
    keyarray+=($KEY)
    valarray+=($VALUE)
done

printf "\nloop through parallel arrays using indices (key/value arrays)\n"
for index in "${!lines[@]}"; do
    printf "%s=%s\n" "${keyarray[$index]}" "${valarray[$index]}"
done

printf "\nfor loop two arrays parallel arrays\n"
declare -a num
declare -a words

num=(1 2 3 4 5 6 7)
words=(one two three four five six seven)

for idx in "${num[@]}"
do
  echo ":${num[$idx-1]}: :${words[$idx-1]}:"
done

printf "\nobsfucating passwords\n"
password=secretvalue
printf '%s\n' $password

eval "printf '*%.0s' {1..$((${#password} -3))}"
printf '%s\n' "${password: -3}"
