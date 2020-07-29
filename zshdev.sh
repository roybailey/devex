#!/bin/zsh
echo Running Developer Profile
SCRIPTDIR=${0%/*}
echo from $fg_bold[blue] $SCRIPTDIR $reset_color

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
alias mvndt="echo mvn dependency:tree; mvn dependency:tree"
alias mvnrun="echo mvn compile && mvn exec:java; mvn compile && mvn exec:java"
mvnversion() {
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
alias kc-config-ava="export KUBECONFIG=/Users/roy.bailey/.kube/config.ava-stage; echo kubectl pointing to ava-stage"
alias kc-pods="echo kubectl get pods --all-namespaces -o wide; kubectl get pods --all-namespaces -o wide"
alias kc-all="echo kubectl get all --all-namespaces -o wide; kubectl get all --all-namespaces -o wide"

alias ava-pods="echo kubectl get pods -n ava; kubectl get pods -n ava"
ava-lookup() {
  kubectl get pods -n ava | grep -vE "\-dev\-" | grep $1 | awk '{print $1}' | tee /dev/tty | pbcopy
}
ava-log() {
  KC_LOG_FOLLOW=
  if [[ "$1" = "-f" ]]; then
    KC_LOG_FOLLOW=$1
    shift;
  fi
  # shellcheck disable=SC2046
  kubectl -n ava logs $KC_LOG_FOLLOW $(kubectl get pods -n ava | grep -vE "\-dev\-" | grep $1 | awk '{print $1}')
}

e2e() {
  E2E_TEST_EMAIL="$1@11fs.com" yarn run test:e2e
}
e2e-rb() {
  E2E_TEST_EMAIL="roy.bailey+$1@11fs.com" yarn run test:e2e
}

alias btoff="sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"
alias bton="sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"

TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
APPS=~/Coding/apps
PATH=$PATH:$SCRIPTDIR/bin; export PATH;

# ============================================================
# Java
# ============================================================
export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_11_HOME=$(/usr/libexec/java_home -v11)

alias java8='export JAVA_HOME=$JAVA_8_HOME'
alias java11='export JAVA_HOME=$JAVA_11_HOME'

#default java8
if [[ ! -a ~/Coding/apps/java ]]; then
    ln -s $JAVA_8_HOME ~/Coding/apps/java
fi

JAVA_HOME=$APPS/java; export JAVA_HOME;
PATH=$PATH:$JAVA_HOME/bin; export PATH;


# ============================================================
# Ant (brew install ant - /usr/local/bin/ant)
# Maven (brew install maven - /usr/local/bin/mvn)
# Gradle (brew install gradle - /usr/local/bin/gradle)
# nvm (brew install nvm; mkdir ~/.nvm)
# ============================================================
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
nvm use 12 --lts

# To find out more visit: https://gulpjs.com/
# npm install gulp-cli -g
# npm install gulp -D


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
kc-config-ava
