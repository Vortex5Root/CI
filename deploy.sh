#!/bin/bash

HOME="$1"
GITHUB_REF="$2"

# Example deployment script
echo "Deploying the application..."

# Navigate to the deployment directory (update this path)
cd $HOME/deployment

# Pull the latest changes
git pull origin $GITHUB_REF

# Install dependencies (if any)
# npm install

# Restart the application (this is an example; update as needed)
# pm2 restart app

echo "Deployment to $GITHUB_REF branch completed."