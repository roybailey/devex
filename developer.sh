#!/bin/bash
echo Running Developer Profile (DEPRECATED - replaced with zshdev.sh)

# shell variables
PS1="\w > "
PS2=": "

ulimit -n 4096
ulimit -u 1024

# aliases
alias l="ls -l"
alias ll="ls -al"

alias bitbucket="echo cd ~/Coding/bitbucket; cd ~/Coding/bitbucket"
alias github="echo cd ~/Coding/github; cd ~/Coding/github"
alias gitview="echo cd ~/Coding/gitview; cd ~/Coding/gitview"
alias temp="echo cd ~/Temp; cd ~/Temp"

alias gs="echo git status; git status"
alias gt="echo git tag; git tag"
alias gp="echo git pull; git pull"

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

# ============================================================
# Java
# ============================================================
JAVA_HOME=$APPS/java; export JAVA_HOME;
PATH=$PATH:$JAVA_HOME/bin; export PATH;

# ============================================================
# SubVersion
# ============================================================
SUBVERSION_HOME=$APPS/subversion; export SUBVERSION_HOME;
PATH=$PATH:$SUBVERSION_HOME/bin; export PATH;

# ============================================================
# Git
# ============================================================
GIT_HOME=$APPS/git; export GIT_HOME;
PATH=$PATH:$GIT_HOME/bin; export PATH;

# ============================================================
# Ant
# ============================================================
ANT_HOME=$APPS/ant; export ANT_HOME;
PATH=$PATH:$ANT_HOME/bin; export PATH;

# ============================================================
# Maven
# ============================================================
MAVEN_HOME=$APPS/maven; export MAVEN_HOME;
M2_HOME=$MAVEN_HOME
PATH=$PATH:$MAVEN_HOME/bin; export PATH;

# ============================================================
# Gradle (brew install gradle - /usr/local/bin/gradle)
# ============================================================
# GRADLE_HOME=$APPS/gradle; export GRADLE_HOME;
# PATH=$PATH:$GRADLE_HOME/bin; export PATH;

# ============================================================
# Groovy
# ============================================================
GROOVY_HOME=$APPS/groovy; export GROOVY_HOME;
GROOVY_CLASSPATH=$GROOVY_HOME/embeddable/groovy-all-1.7.4.jar
PATH=$PATH:$GROOVY_HOME/bin; export PATH;

# ============================================================
# Scala
# ============================================================
SCALA_HOME=$APPS/scala; export SCALA_HOME;
SCALA_CLASSPATH=$SCALA_HOME/lib/scala-library.jar
PATH=$PATH:$SCALA_HOME/bin; export PATH;

# ============================================================
# MySql Settings
# ============================================================
MYSQL_HOME=/usr/local/mysql; export MYSQL_HOME
PATH=$MYSQL_HOME/bin:$PATH; export PATH

# ============================================================
# JIRA
# ============================================================
JIRA_HOME=~/Coding/software/jira-home; export JIRA_HOME;
JIRA_DIST=$APPS/jira; export JIRA_DIST;
alias jira-start="echo $JIRA_DIST/bin/start-jira.sh; $JIRA_DIST/bin/start-jira.sh"
alias jira-stop="echo $JIRA_DIST/bin/stop-jira.sh; $JIRA_DIST/bin/stop-jira.sh"

# ============================================================
# Cassandra
# ============================================================
CASSANDRA_HOME=$APPS/cassandra; export CASSANDRA_HOME;
alias cassandra-start="echo $CASSANDRA_HOME/bin/cassandra -f; $CASSANDRA_HOME/bin/cassandra -f"
alias cassandra-cli="echo $CASSANDRA_HOME/bin/cassandra-cli; $CASSANDRA_HOME/bin/cassandra-cli"
alias cassandra-cql="echo $CASSANDRA_HOME/bin/cqlsh; $CASSANDRA_HOME/bin/cqlsh"

# ============================================================
# Neo4J
# ============================================================
NEO4J_HOME=$APPS/neo4j; export NEO4J_HOME;
alias neo4j-start="echo $NEO4J_HOME/bin/neo4j start; $NEO4J_HOME/bin/neo4j start"
alias neo4j-stop="echo $NEO4J_HOME/bin/neo4j stop; $NEO4J_HOME/bin/neo4j stop"
alias neo4j-clean="echo rm -rf $NEO4J_HOME/data/graph.db; rm -rf $NEO4J_HOME/data/graph.db"

# ============================================================
# ZooKeeper
# ============================================================
ZOOKEEPER_HOME=$APPS/zookeeper; export ZOOKEEPER_HOME;
alias zookeeper-start="echo $ZOOKEEPER_HOME/bin/zkServer.sh start; $ZOOKEEPER_HOME/bin/zkServer.sh start"
alias zookeeper-stop="echo $ZOOKEEPER_HOME/bin/zkServer.sh stop; $ZOOKEEPER_HOME/bin/zkServer.sh stop"
alias zookeeper-clean="echo $ZOOKEEPER_HOME/bin/zkCleanup.sh; $ZOOKEEPER_HOME/bin/zkCleanup.sh"

# ============================================================
# Redis
# ============================================================
REDIS_HOME=$APPS/redis; export REDIS_HOME;
alias redis-start="echo $REDIS_HOME/src/redis-server; $REDIS_HOME/src/redis-server"

# ============================================================
# Couchbase
# ============================================================
COUCHBASE_HOME=$APPS/couchbase; export COUCHBASE_HOME;
alias couchbase-start="echo open $COUCHBASE_HOME/Couchbase\ Server.app; open $COUCHBASE_HOME/Couchbase\ Server.app"

# ============================================================
# Couchdb
# ============================================================
COUCHDB_HOME=$APPS/couchdb; export COUCHDB_HOME;
alias couchdb-start="echo open $COUCHDB_HOME/Apache\ CouchDB.app; open $COUCHDB_HOME/Apache\ CouchDB.app"

# ============================================================
# ElasticSearch
# ============================================================
ELASTIC_HOME=$APPS/elastic; export ELASTIC_HOME;
alias elastic-start="echo $ELASTIC_HOME/bin/elasticsearch -f; $ELASTIC_HOME/bin/elasticsearch -f"

# ============================================================
# MongoDB
# ============================================================
MONGODB_HOME=$APPS/mongodb; export MONGODB_HOME;
MONGODB_DATA=$MONGODB_HOME/work/data/db; export MONGODB_DATA;
alias mongodb-start="echo $MONGODB_HOME/bin/mongod --rest --dbpath $MONGODB_DATA; $MONGODB_HOME/bin/mongod --rest --dbpath $MONGODB_DATA"

# ============================================================
# Hadoop
# ============================================================
# HADOOP_HOME=$APPS/hadoop; export HADOOP_HOME;
# HADOOP_DATA=$HADOOP_HOME/work; export HADOOP_DATA;
# alias hadoop-start="echo $HADOOP_HOME/bin/hadoop; $HADOOP_HOME/bin/hadoop"

# ============================================================
# OrientDB
# ============================================================
ORIENTDB_HOME=$APPS/orientdb; export ORIENTDB_HOME;
alias orientdb-start="echo $ORIENTDB_HOME/bin/server.sh; $ORIENTDB_HOME/bin/server.sh"

# ============================================================
# Riak
# ============================================================
RIAK_HOME=$APPS/riak; export RIAK_HOME;
alias riak-start="echo $RIAK_HOME/bin/riak start; $RIAK_HOME/bin/riak start"
alias riak-stop="echo $RIAK_HOME/bin/riak stop; $RIAK_HOME/bin/riak stop"
