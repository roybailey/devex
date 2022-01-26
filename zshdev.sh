#!/bin/zsh
echo Running Developer Profile
SCRIPTDIR=${0%/*}
echo from $fg_bold[blue] $SCRIPTDIR $reset_color
echo
echo

# shell variables (these were added to help running cassandra locally long back)
# ulimit -n 4096
# ulimit -u 1024

# aliases
alias lastmodified='find . -type f -exec stat -f "%Sm %N" -t "%Y%m%d%H%M" {} \; | sort -r'

alias bitbucket="echo cd ~/Coding/bitbucket; cd ~/Coding/bitbucket"
alias github="echo cd ~/Coding/github; cd ~/Coding/github"
alias gitlab="echo cd ~/Coding/gitlab; cd ~/Coding/gitlab"
alias gitview="echo cd ~/Coding/gitview; cd ~/Coding/gitview"
alias git11fs="echo cd ~/Coding/git11fs; cd ~/Coding/git11fs"

alias temp="echo cd ~/Temp; cd ~/Temp"

alias gs="echo git status; git status"
alias gt="echo git tag; git tag"
alias gp="echo git pull; git pull"

alias git-config-roybaileybiz='git config user.name "Roy Bailey"; git config user.email "roybaileybiz@gmail.com"'
alias git-config-11fs='git config user.name "Roy Bailey"; git config user.email "roy.bailey@11fs.com"'
alias git-config-global-clear-user='git config --global --unset user.name; git config --global --unset user.email'
alias git-config-clear-user='git config --unset user.name; git config --unset user.email'

alias mvnci="echo mvn clean install; mvn clean install"
alias mvncist="echo mvn clean install -DskipTests=true; mvn clean install -DskipTests=true"
alias mvndt="echo mvn dependency:tree; mvn dependency:tree"
alias mvnsrc="echo mvn source:jar install dependency:sources -DskipTests=true; mvn source:jar install dependency:sources -DskipTests=true"
alias mvnrun="echo mvn compile && mvn exec:java; mvn compile && mvn exec:java"
mvn-new-version() {
  echo "mvn versions:set -DnewVersion=$1"
  mvn versions:set -DnewVersion=$1
}

alias grb="echo gradle build; gradle build"
alias grd="echo gradle dependencies; gradle dependencies"
alias grpom="echo gradle pom; gradle pom"

alias npm-global-ls="echo npm -g ls --depth 0; npm -g ls --depth 0"
alias npm-tape="echo npm run tape; npm run tape"
alias babel-tape="echo tape -r babel-register; tape -r babel-register"

alias dc-up="docker-compose up"

alias kc="kubectl"
alias kc-config-docker="export KUBECONFIG=/Users/roy.bailey/.kube/config.docker-desktop; echo kubectl pointing to docker-desktop"
alias kc-pods="echo kubectl get pods --all-namespaces -o wide; kubectl get pods --all-namespaces -o wide"
alias kc-all="echo kubectl get all --all-namespaces -o wide; kubectl get all --all-namespaces -o wide"

kc-lookup() {
  kubectl get pods | grep $1 | awk '{print $1}' | tee /dev/tty | pbcopy
}
kc-logs() {
  KC_LOG_FOLLOW=
  if [[ "$1" = "-f" ]]; then
    KC_LOG_FOLLOW=$1
    shift;
  fi
  # shellcheck disable=SC2046
  kubectl logs $KC_LOG_FOLLOW $(kubectl get pods | grep $1 | awk '{print $1}')
}

alias btoff="sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"
alias bton="sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"

TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
APPS=~/Coding/apps
PATH=$PATH:$SCRIPTDIR/bin; export PATH;


# ============================================================
# Ant (brew install ant - /usr/local/bin/ant)
# Maven (brew install maven - /usr/local/bin/mvn)
# Gradle (brew install gradle - /usr/local/bin/gradle)
# nvm (brew install nvm; mkdir ~/.nvm)
# ============================================================
if ! command -v brew &> /dev/null; then
    echo "brew not found, see https://brew.sh/"
fi
if ! command -v ant &> /dev/null; then
    echo "ant not found, run 'brew install ant'"
fi
if ! command -v mvn &> /dev/null; then
    echo "maven not found, run 'brew install maven'"
fi
if ! command -v gradle &> /dev/null; then
    echo "gradle not found, run 'brew install gradle'"
fi

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

if ! command -v nvm &> /dev/null; then
    echo "nvm not found, run 'brew install nvm; mkdir ~/.nvm'"
fi

nvm use --lts

# To find out more visit: https://gulpjs.com/
# npm install gulp-cli -g
# npm install gulp -D


# ============================================================
# Java
# ============================================================

if ! command -v sdk &> /dev/null
then
    echo "sdk not found, see https://sdkman.io/install"
fi

SDKMAN_JAVA_FOLDER=`cd ~/.sdkman/candidates/java/; pwd`
SDKMAN_JAVA_8=`ls $SDKMAN_JAVA_FOLDER | grep 8.0`
SDKMAN_JAVA_11=`ls $SDKMAN_JAVA_FOLDER | grep 11.0`

if [ "$SDKMAN_JAVA_8" = "" ]; then
  echo sdk java v8 not installed, falling back to Java install locations
  export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
else
  export JAVA_8_HOME=$SDKMAN_JAVA_FOLDER/$SDKMAN_JAVA_8
fi

if [ "$SDKMAN_JAVA_11" = "" ]; then
  echo sdk java v11 not installed, falling back to Java install locations
  export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
else
  export JAVA_11_HOME=$SDKMAN_JAVA_FOLDER/$SDKMAN_JAVA_11
fi

alias java8='sdk use java $SDKMAN_JAVA_8;  sdk home java $SDKMAN_JAVA_8'
alias java11='sdk use java $SDKMAN_JAVA_11;  sdk home java $SDKMAN_JAVA_11'

echo SDKMAN_JAVA_FOLDER=$SDKMAN_JAVA_FOLDER
echo SDKMAN_JAVA_8=$SDKMAN_JAVA_8
echo SDKMAN_JAVA_11=$SDKMAN_JAVA_11
echo JAVA_8_HOME=$JAVA_8_HOME
echo JAVA_11_HOME=$JAVA_11_HOME

# default to java11
java11
echo
echo JAVA_HOME=$JAVA_HOME

export LOCAL_POSTGRES_URL=jdbc:postgresql://localhost:5432/postgres
export LOCAL_POSTGRES_USERNAME=postgres
export LOCAL_POSTGRES_PASSWORD=localhost

# ============================================================
# WordPress and MySQL
# brew install mysql-client
# ============================================================
PATH=$PATH:/usr/local/opt/mysql-client/bin; export PATH;


# ============================================================
# Flutter
# ============================================================
export FLUTTER_HOME=~/Coding/apps/flutter
PATH=$PATH:$FLUTTER_HOME/bin; export PATH;


# ============================================================
# Tips & Reminders
# ============================================================

. $SCRIPTDIR/bin/favorites.sh
. $SCRIPTDIR/bin/versions.sh

