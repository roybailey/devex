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
alias temp="echo cd ~/Temp; cd ~/Temp"

alias gs="echo git status; git status"
alias gt="echo git tag; git tag"
alias gp="echo git pull; git pull"

alias git-config-roybaileybiz='git config user.name "Roy Bailey"; git config user.email "roybaileybiz@gmail.com"'
alias git-config-peimedia='git config user.name "Roy Bailey"; git config user.email "roy.b@peimedia.com"'
alias git-config-global-clear-user='git config --global --unset user.name; git config --global --unset user.email'
alias git-config-clear-user='git config --unset user.name; git config --unset user.email'

alias mvnci="echo mvn clean install; mvn clean install"
alias mvndt="echo mvn dependency:tree; mvn dependency:tree"
alias mvnrun="echo mvn compile && mvn exec:java; mvn compile && mvn exec:java"
alias mvnversion='function _blah(){ echo "mvn versions:set -DnewVersion=$1"; mvn versions:set -DnewVersion=$1; };_blah'

alias grb="echo gradle build; gradle build"
alias grd="echo gradle dependencies; gradle dependencies"
alias grpom="echo gradle pom; gradle pom"

alias npm-global-ls="echo npm -g ls --depth 0; npm -g ls --depth 0"
alias npm-tape="echo npm run tape; npm run tape"
alias babel-tape="echo tape -r babel-register; tape -r babel-register"

alias btoff="sudo kextunload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"
alias bton="sudo kextload -b com.apple.iokit.BroadcomBluetoothHostControllerUSBTransport"

TMP=/tmp; export TMP
TMPDIR=$TMP; export TMPDIR
APPS=~/Coding/apps
PATH=$PATH:~/Coding/github/devex/bin; export PATH;

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


# ============================================================
# Tips & Reminders
# ============================================================

echo
echo ---------- coding tips ----------
echo $fg_bold[blue] "gss/gsb $reset_color 'git status'"
echo $fg_bold[blue] "gaa     $reset_color 'git add --all'"
echo $fg_bold[blue] "gcam    $reset_color 'git commit -a -m <www.conventionalcommits.org message>'"
echo $fg_bold[blue] "    feat:$reset_color allow provided config object to extend other configs"
echo $fg_bold[blue] "    docs:$reset_color correct spelling of CHANGELOG"
echo $fg_bold[blue] "    fix:$reset_color minor typos in code, fixes issue #12"
echo $fg_bold[blue] "gpd     $reset_color 'git push --dry-run'"
echo $fg_bold[blue] "gpsup   $reset_color 'git push --set-upstream origin <git_current_branch>'"
echo $fg_bold[blue] "gpu     $reset_color 'git push upstream'"
echo
echo ---------- software installed ----------
echo nvm `nvm --version`
echo npm `npm --version`
echo node `node --version`
echo `python3 --version`
echo `brew --version`
echo `git --version`
echo `java -version`
