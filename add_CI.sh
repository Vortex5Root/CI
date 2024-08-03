#!/bin/bash

#Optional Parameters
runner_host=""
runner_port=""
runner_user=""
runner_password=""

# Parse the optional flags
while getopts "h:p:u:pu:" opt; do
  case $opt in
    rh) runner_host="$OPTARG"
    ;;
    rp) runner_port="$OPTARG"
    ;;
    ru) runner_user="$OPTARG"
    ;;
    rpw) runner_password="$OPTARG"
    ;;
    update) ~/tools/CI/make update
    ;;
    h) echo "Help-Menu\n-h: for help\n-rh: runner_host\n-rp: runner_port\n-ru: runner_user\n-rpw: runner_password"
    ;;
    \?) echo "Invalid option -$OPTARG use -h for help" >&2 exit 1
    ;;
  esac
done

#Shift the arguments so that the remaining are the non-flag arguments
shift $((OPTIND -1))

if [ "$#" -ne 4 ]; then
    echo "Usage: add_ci -h for help"
    exit 1
fi

GITHUB_USER_OR_ORG="$1"
REPO_NAME="$2"
PERSONAL_ACCESS="$3"
runner_type="$4"

# Run the SSH commands only if the necessary SSH details are provided
if [ -n "$runner_host" ] && [ -n "$runner_port" ] && [ -n "$runner_user" ] && [ -n "$runner_password" ]; then
    sshpass -p "$runner_password" scp -r -o StrictHostKeyChecking=no -P "$runner_port" ~/CI/server/ "$runner_user"@"$runner_host":~/
    sshpass -p "$runner_password" ssh -o StrictHostKeyChecking=no -p "$runner_port" "$runner_user"@"$runner_host" "cd ~/server && chmod +x ./setup_runner/*.sh && ./setup_runner/Runner.sh $GITHUB_USER_OR_ORG $REPO_NAME $PERSONAL_ACCESS $runner_type"
fi

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

echo "Don't forget to set up the required environment variables and secrets for deployment."
