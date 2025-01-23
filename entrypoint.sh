#!/bin/sh

GITHUB_TOKEN=$1
GIPHY_APIKEY=$2

pull_req_number= $(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
echo PR_NUMBER - $pull_req_number

giphy_response= $(curl -s "https://api.giphy.com/v1/gifs/random?api_key=$GIPHY_APIKEY&tag=&rating=g")
echo Giphy response - $giphy_response

gif_url= $(echo "$giphy_response" | jq --raw-output .data.images.downsized.url)

comment_response = $(curl -sX POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -d "{\"body\":\"### PR - #$pull_req_number\n ### Thank you for your contribution. \n ![Gif]($gif_url)\"}"
  "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$pull_req_number/comments" )

echo response - $comment_response