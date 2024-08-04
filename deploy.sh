#!/bin/bash

REPO_NAME=""
GITHUB_REF=""

remote_url=$(git config --get remote.origin.url)

# Extract the repo name from the remote URL
repo_name=$(basename -s .git $remote_url)
if [ -x "$(command -v git)" ] && [ "$repo_name" = "$REPO_NAME" ]; then
    echo "Creating beta and dev branches..."
    cd ./$REPO_NAME
else
    git clone git@github.com:$GITHUB_USER_OR_ORG/$REPO_NAME.git
    cd $REPO_NAME
fi

# Example deployment script
echo "Deploying the application..."

# Pull the latest changes
git pull origin $GITHUB_REF

# Install dependencies (if any)
# npm install

# Restart the application (this is an example; update as needed)
# pm2 restart app

echo "Deployment to $GITHUB_REF branch completed."