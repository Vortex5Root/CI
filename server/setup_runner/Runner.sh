#!/bin/bash

# Variables - Fill these in with your information
GITHUB_USER_OR_ORG="$1"
REPO_NAME="$2" # Leave empty for organization or enterprise runners
PERSONAL_ACCESS_TOKEN="$3"
if [ "$4" = "user" ]; then
    TYPE="user"
    # Add your logic here for when the fourth argument is "user"
else
    TYPE="org"
    # Optional: Add your logic here for when the fourth argument is not "user"
fi
RUNNER_VERSION="2.314.1" # Specify a runner version if needed

echo "Type: $TYPE"
echo "User/Org: $GITHUB_USER_OR_ORG"
echo "GitHub $TYPE: $REPO_NAME"
echo "Token: $PERSONAL_ACCESS_TOKEN"
echo "Runner Version: $RUNNER_VERSION"

echo "Type Select $4"

ssh-keyscan -H "github.com" >> ~/.ssh/known_hosts

if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y jq
fi

# Step 1: Generate Runner Token
generate_runner_token() {
    if [ "$TYPE" = "org" ]; then
        # Generate token for an organization
        RUNNER_TOKEN=$(curl -L \
            -X POST \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer $PERSONAL_ACCESS_TOKEN" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            "https://api.github.com/orgs/$GITHUB_USER_OR_ORG/actions/runners/registration-token" | jq -r '.token')
        echo -e "\ncurl -L \
            -X POST \
            -H \"Accept: application/vnd.github+json\" \
            -H \"Authorization: Bearer $PERSONAL_ACCESS_TOKEN\" \
            -H \"X-GitHub-Api-Version: 2022-11-28\" \
            \"https://api.github.com/orgs/$GITHUB_USER_OR_ORG/actions/runners/registration-token\""
    fi
    if [ "$TYPE" = "user" ]; then
        # Generate token for a specific repository
        RUNNER_TOKEN=$(curl -L \
            -X POST \
            -H "Accept: application/vnd.github+json" \
            -H "Authorization: Bearer $PERSONAL_ACCESS_TOKEN" \
            -H "X-GitHub-Api-Version: 2022-11-28" \
            "https://api.github.com/repos/$GITHUB_USER_OR_ORG/$REPO_NAME/actions/runners/registration-token" | jq -r '.token')
        echo "curl -L \
            -X POST \
            -H \"Accept: application/vnd.github+json\" \
            -H \"Authorization: Bearer $PERSONAL_ACCESS_TOKEN\" \
            -H \"X-GitHub-Api-Version: 2022-11-28\" \
            \"https://api.github.com/repos/$GITHUB_USER_OR_ORG/$REPO_NAME/actions/runners/registration-token\""
    fi
    if [ -z "$RUNNER_TOKEN" ]; then
        echo "RUNNER_TOKEN is empty or non-existent"
        exit 0
        # Add your logic here for when the RUNNER_TOKEN is empty or non-existent
    else
        echo "RUNNER_TOKEN: $RUNNER_TOKEN"
        # Add your logic here for when the RUNNER_TOKEN exists
    fi
    echo "Runner Token: $RUNNER_TOKEN"
    read -p "Presse [Enter] to continue..."
}

# Step 2: Create Dockerfile
create_dockerfile() {
    docker pull debian:buster
    docker run --rm debian:buster /bin/sh -c 'echo Hello, World!'
    docker run --rm debian:buster /bin/sh -c 'ls -l /bin/sh'
    if [ "$TYPE" = "org" ]; then
        cat >Dockerfile <<EOF
FROM  debian:buster

# Install necessary packages
# Note: The specific packages you need might vary.
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    sudo \
    jq \
    libicu-dev \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# Create a runner directory
RUN mkdir /actions-runner
WORKDIR /actions-runner

# Create a non-root user (e.g., `runner`) without password and switch to it
# Replace 'runner' with your preferred username
RUN useradd -m runner && chown -R runner:runner /actions-runner

# Switch to the non-root user
USER runner


# Download the latest runner package
RUN curl -O -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -o actions-runner-linux-x64-\$RUNNER_VERSION.tar.gz

# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

RUN ["/bin/sh", "-c", "ls -l /bin/sh"]

# Configure the runner
RUN ["/bin/sh", "-c", "./config.sh --verbose --url https://github.com/$GITHUB_USER_OR_ORG --token $RUNNER_TOKEN"]

# Run the runner
CMD ["./run.sh"]
EOF
    fi
    if [ "$TYPE" = "user" ]; then
        cat >Dockerfile <<EOF
FROM  debian:buster

# Install necessary packages
# Note: The specific packages you need might vary.
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    sudo \
    jq \
    libicu-dev \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# Create a runner directory
RUN mkdir /actions-runner
WORKDIR /actions-runner

# Create a non-root user (e.g., `runner`) without password and switch to it
# Replace 'runner' with your preferred username
RUN useradd -m runner && chown -R runner:runner /actions-runner

# Switch to the non-root user
USER runner


# Download the latest runner package
RUN curl -O -L https://github.com/actions/runner/releases/download/v$RUNNER_VERSION/actions-runner-linux-x64-$RUNNER_VERSION.tar.gz -o actions-runner-linux-x64-\$RUNNER_VERSION.tar.gz

# Extract the installer
RUN tar xzf ./actions-runner-linux-x64-$RUNNER_VERSION.tar.gz

RUN ["/bin/sh", "-c", "ls -l /bin/sh"]

# Configure the runner
RUN ["/bin/sh", "-c", "./config.sh --verbose --url https://github.com/$GITHUB_USER_OR_ORG/$REPO_NAME --token $RUNNER_TOKEN"]
# Run the runner
CMD ["./run.sh"]
EOF
    fi
}

# Step 3: Build and Run Docker Container
build_and_run_container() {
    if !! docker ps -a --filter "name=github-actions-runner-$REPO_NAME" --format "{{.Names}}" | grep -q "github-actions-runner-$REPO_NAME"; then
        docker build -t github-runner-$REPO_NAME .
        docker run -d --name github-actions-runner-$REPO_NAME github-runner-$REPO_NAME
    else
        echo "Runner: $REPO_NAME already exists!"
    fi
}

docker_install() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y docker.io
        sudo systemctl start docker
        sudo systemctl enable docker
        sudo usermod -aG docker $USER
    fi
}

docker_check_group() {
    if ! groups $USER | grep &>/dev/null '\bdocker\b'; then
        echo "Adding user to docker group..."
        sudo usermod -aG docker $USER
        echo "Please log out and log back in to apply the changes."
    fi
}

# Execute the steps
docker_install
docker_check_group
generate_runner_token
create_dockerfile
build_and_run_container
