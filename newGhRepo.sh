#! /bin/bash

read -p "Enter your GitHub token: " GITHUB_TOKEN
echo

repoName=$1 

while [ -z "$repoName" ]
do 
echo 'Provide a Repository Name'
read -r -p $'Repository name: ' repoName
done

echo "# $repoName" >> README.md
git init
git add .
git commit -m "First Commit"

curl -u ccarlossalazar:$GITHUB_TOKEN https://api.github.com/user/repos -d '{"name": "'"$repoName"'", "private":false}'

GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/ccarlossalazar/"$repoName" | jq -r '.clone_url')

git branch -M main
git remote add origin $GIT_URL
git push -u origin main
