#!/bin/bash

REPO_NAME=""
GITHUB_USER_OR_ORG=""
GITHUB_REF="$1"

if [ -d "$REPO_NAME" ]; then
    cd ./$REPO_NAME
else
    git clone https://github.com/$GITHUB_USER_OR_ORG/$REPO_NAME.git
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