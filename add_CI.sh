#!/bin/bash

# Optional Parameters
runner_host=""
runner_port=""
runner_user=""
runner_password=""

GITHUB_USER_OR_ORG=""
REPO_NAME=""
PERSONAL_ACCESS=""
REPO_TYPE=""

debug=false

# Function to display the help menu
show_help() {
  echo "Usage: $0 -git <GITHUB_USER_OR_ORG> -repo <REPO_NAME> -key <PERSONAL_ACCESS> [Runner-Options]"
  echo ""
  echo "Options:"
  echo "  -h                Show this help message"
  echo "Mandatory Options:"
  echo "  -git <name> or --gitname <name>   Set the GitHub user or organization name"
  echo "  -repo <name> or --reponame <name>  Set the repository name"
  echo "  -key <classic_token> or --personalaccess <classic_token> Set the personal access token"
  echo "  -rtype <type> (type: user or org) Set the repository type"
  echo "Setup Runner Options:"
  echo "  -rh <host>        Set the runner host"
  echo "  -rp <port>        Set the runner port"
  echo "  -ru <user>        Set the runner user"
  echo "  -rpw <password>   Set the runner password"
  echo "  --update          Update the CI tools"
  echo ""
}

# Parse the optional flags
while [[ $# -gt 0 ]]; do
  key="$1"
  #echo $key
  case $key in
    -h)
      show_help
      exit 0
      ;;
    -rh)
      runner_host="$2"
      shift # past argument
      shift # past value
      ;;
    -rp)
      runner_port="$2"
      shift # past argument
      shift # past value
      ;;
    -ru)
      runner_user="$2"
      shift # past argument
      shift # past value
      ;;
    -rpw)
      runner_password="$2"
      shift # past argument
      shift # past value
      ;;
    -git)
      GITHUB_USER_OR_ORG="$2"
      shift # past argument
      shift # past value
      ;;
    -repo)
      REPO_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    -key)
      PERSONAL_ACCESS="$2"
      shift # past argument
      shift # past value
      ;;
    -rtype)
      REPO_TYPE="$2"
      shift # past argument
      shift # past value
      ;;
    --gitname)
      GITHUB_USER_OR_ORG="$2"
      shift # past argument
      shift # past value
      ;;
    --reponame)
      REPO_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    --personalaccess)
      PERSONAL_ACCESS="$2"
      shift # past argument
      shift # past value
      ;;
    --update)
      ~/tools/CI/make update
      shift # past argument
      ;;
    --debug)
      debug=true
      shift # past argument
      ;;
    *)
      echo "Invalid option $key" >&2
      show_help
      exit 1
      ;;
  esac
done

if $debug; then
  # Your script logic here
  echo "GitHub User or Organization: $GITHUB_USER_OR_ORG"
  echo "Repository Name: $REPO_NAME"
  echo "Personal Access Token: $PERSONAL_ACCESS"
  echo "Runner Host: $runner_host"
  echo "Runner Port: $runner_port"
  echo "Runner User: $runner_user"
  echo "Runner Password: $runner_password"
fi
# Shift the arguments so that the remaining are the non-flag arguments
shift $((OPTIND -1))

if [ -n "$GITHUB_USER_OR_ORG" ] && [ -n "$REPO_NAME" ] && [ -n "$PERSONAL_ACCESS" ] && [ -n "$REPO_TYPE" ]; then
  echo "Copying the CI tools to the server..."

  # Run the SSH commands only if the necessary SSH details are provided
  if [ -n "$runner_host" ] && [ -n "$runner_port" ] && [ -n "$runner_user" ] && [ -n "$runner_password" ]; then
      sshpass -p "$runner_password" scp -r -o StrictHostKeyChecking=no -P "$runner_port" ~/tools/CI/server/ "$runner_user"@"$runner_host":~/
      sshpass -p "$runner_password" ssh -o StrictHostKeyChecking=no -p "$runner_port" "$runner_user"@"$runner_host" "cd ~/server && chmod +x ./setup_runner/*.sh && ./setup_runner/Runner.sh $GITHUB_USER_OR_ORG $REPO_NAME $PERSONAL_ACCESS $REPO_TYPE"
  fi

  remote_url=$(git config --get remote.origin.url)

  # Extract the repo name from the remote URL
  repo_name=$(basename -s .git $remote_url)
  echo $repo_name
  echo $REPO_NAME
  echo $repo_name==$REPO_NAME
  if [ -x "$(command -v git)" ] && [ "$repo_name"=="$REPO_NAME" ]; then
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
else
  echo "Usage: add_ci -h for help"
  exit 1
fi