#!/bin/bash
#
# A script for validating merge-requests and fail the pipeline if necessary
#
# To be used in conjuction with Settings > General > Merge Requests > Pipelines must succeed
# and .gitlab-ci.yml block as follows:
#
# merge_requests:
#  stage: test
#  script:
#    - .deploy/merge-request.sh
#  only:
#    - merge_requests
#
# Also see https://docs.gitlab.com/ee/ci/variables/predefined_variables.html for variables that might be useful

# ------------------------------------------------------------
# Rule 1 : Validate merge request to master has matching version tag
# ------------------------------------------------------------

# get the tag on this commit
TAG=$(git tag --points-at HEAD)

# get the version from package.json
PKG=v$(cat package.json | grep version | head -n 1 | cut -d'"' -f4)

# get the production branch name, defaul to master
if [ "$PRODUCTION_BRANCH" = "" ]; then
  export PRODUCTION_BRANCH="master"
fi

echo "Validating merge request from $CI_MERGE_REQUEST_SOURCE_BRANCH_NAME to $CI_MERGE_REQUEST_TARGET_BRANCH_NAME"

# we can't restrict merge_request to only master branch in .gitlab-ci.yml so we do it here
if [ "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" == "$PRODUCTION_BRANCH" ]; then
  echo "Production branch merge ($PRODUCTION_BRANCH) must have tag to match version in package.json"
  echo "Checking tag ($TAG) to match package.json version ($PKG) before merge to $PRODUCTION_BRANCH"
  if [ "$TAG" != "$PKG" ]; then
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "!!!!! VERSION TAG NOT FOUND for version being merged to production branch  !!!!!"
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "Either you forgot to tag this commit before merging to production branch,"
    echo "or you forgot to up the version from an earlier release to production."
    exit 1
  fi
fi

