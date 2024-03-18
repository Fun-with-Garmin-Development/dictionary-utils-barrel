#!/bin/bash

# This script uploads an asset to a GitHub release using GitHub REST API.
# It takes four arguments: the owner of the repository, the name of the repository, the name of the release tag, and the path to the file to be uploaded.
# It first retrieves the ID of the release associated with the given tag using the GitHub API.
# Then, it uploads the file as an asset to that release.
# Note: This script requires that you have a GitHub Personal Access Token stored in an environment variable named GITHUB_TOKEN.

# check if parameters are passed
if [ $# -ne 4 ]
  then
    echo "Incorrect number of arguments supplied. Supply owner name, repo name, tag name and file path."
    exit 1
fi

# get parameters
owner=$1
repo=$2
tag=$3
file=$4

# get the release ID for the tag
release_id=$(curl --silent --show-error --header "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$owner/$repo/releases/tags/$tag" | \
  jq '.id')

# upload the asset
curl --data-binary @"$file" -H "Authorization: token $GITHUB_TOKEN" -H "Content-Type: application/octet-stream" \
  "https://uploads.github.com/repos/$owner/$repo/releases/$release_id/assets?name=$(basename $file)"