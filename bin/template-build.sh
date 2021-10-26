#!/bin/bash

echo "Building all projects within this mono-repo"
SERVER=("project-folder-one" "project-folder-two" "project-folder-three")

for ((idx = 0; idx < ${#SERVER[@]}; idx++)); do
    REPO="${SERVER[idx]}"
    LOGFILE="../${REPO}.log"
    echo
    echo "Building ${REPO}..."
    cd ../"${SERVER[idx]}"
    if mvn clean install > ${LOGFILE}; then
        echo "Finished ${REPO} OK"
    else
        echo "Finished ${REPO} Failed"
    fi
    grep "SUCCESS\|FAIL" ${LOGFILE}
done

cd ..
