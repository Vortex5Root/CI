#!/bin/bash

if [ "$#" -ne 8 ]; then
    echo "Usage: add_ci <runner_host> <runner_port> <runner_user> <runner_password> <GITHUB_USER_OR_ORG> <REPO_NAME> <PERSONAL_ACCESS> <runner_type>"
    exit 1
fi

runner_host="$1"
runner_port="$2"
runner_user="$3"
runner_password="$4"

GITHUB_USER_OR_ORG="$5"
REPO_NAME="$6"
PERSONAL_ACCESS="$7"
runner_type="$8"

sshpass -p "$runner_password" scp -r -o StrictHostKeyChecking=no -p "$runner_port" ~/CI/server/ "$runner_user"@"$runner_host":~/
sshpass -p "$runner_password" ssh -o StrictHostKeyChecking=no -p "$runner_port" "$runner_user"@"$runner_host" "cd ~/server && chmod +x ./setup_runner/*.sh && ./setup_runner/Runner.sh $GITHUB_USER_OR_ORG $REPO_NAME $PERSONAL_ACCESS $runner_type"

remote_url=$(git config --get remote.origin.url)

# Extract the repo name from the remote URL
repo_name=$(basename -s .git $remote_url)

if [ -x "$(command -v git)" ] && [ $repo_name=="$REPO_NAME" ]; then
    echo "Creating beta and dev branches..."
else
    git clone git@github.com:$GITHUB_USER_OR_ORG/$REPO_NAME.git
    cd $REPO_NAME
fi
git checkout -b beta
git checkout -b dev
cp ~/tools/CI/deploy.sh ./deploy.sh
cp ~/tools/CI/deploy.yaml ./.github/workflows/deploy.yaml
git add .
git commit -m "Add deployment scripts"
git push origin beta
echo "Dont forget to set 