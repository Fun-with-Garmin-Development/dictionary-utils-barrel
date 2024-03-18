#!/bin/bash
#
# This script creates a release on GitHub. 
# It takes 3 parameters:
# 1. repo name
# 2. tag name
# 3. release notes file path
#
# Usage: ./create-release.sh <repo> <tag> <release_notes_file_path>
#
# Warning: This script requires the GitHub CLI to be installed and configured.
#
# check if parameters are passed
if [ $# -ne 3 ]
  then
    echo "Incorrect number of arguments supplied. Supply repo name, tag name and release notes file path."
    exit 1
fi

# get parameters
repo=$1
tag=$2
notes_file=$3

# create the release
gh release create $tag -R $repo -F $notes_file