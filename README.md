<h1 align="center">CI</h1>
<p align="center">
    <a href="https://github.com/Vortex5Root/CI/blob/master/LICENSE"><img src="https://img.shields.io/github/license/Vortex5Root/CI.svg" alt="License">
    <a href="https://github.com/Vortex5Root/CI/releases"><img src="https://img.shields.io/github/downloads/Vortex5Root/CI/total.svg" alt="GitHub all releases"></a><br>
    <a href="https://github.com/Vortex5Root/CI/network"><img src="https://img.shields.io/github/forks/Vortex5Root/CI.svg" alt="GitHub forks"></a>
    <a href="https://github.com/Vortex5Root/CI/stargazers"><img src="https://img.shields.io/github/stars/Vortex5Root/CI.svg" alt="GitHub stars"></a>
    <a href="https://github.com/Vortex5Root/CI/watchers"><img src="https://img.shields.io/github/watchers/Vortex5Root/CI.svg" alt="GitHub watchers"></a><br>
    <a href="https://github.com/Vortex5Root/CI/issues"><img src="https://img.shields.io/github/issues/Vortex5Root/CI.svg" alt="GitHub issues"></a>
    <a href="https://github.com/Vortex5Root/CI/pulls"><img src="https://img.shields.io/github/issues-pr/Vortex5Root/CI.svg" alt="GitHub pull requests"></a>
    <a href="https://github.com/Vortex5Root/CI/commits/master"><img src="https://img.shields.io/github/last-commit/Vortex5Root/CI.svg" alt="GitHub last commit"></a>
</p>

# Introduction

> **CI** is a collection of scripts that can be used to automate the process of building and deploying software. It is designed to be used with GitHub Actions, but can be used with other CI/CD services as well.

| Problem | Solution |
| --- | --- |
| **How to integrate the project workflow on every github project?** | **This tool creates a workflow standard for every github project thus facilitating the deployment of the projects.** |

# How to install

1. Clone the repository:
```bash
git clone https://github.com/Vortex5Root/CI.git
```

2. Change the directory:
```bash
cd CI
```

3. Run the installation script:
```bash
make
```

# How to use

```bash
add_ci [-h runner_host] [-p runner_port] [-u runner_user] [-pu runner_password] <GITHUB_USER_OR_ORG> <REPO_NAME> <PERSONAL_ACCESS> <runner_type>
```
- **`runner_host`** *(Optional)*: The IP address of the machine you want to SSH into for deploying the GitHub Runner. This is only needed if you are using a self-hosted runner.

- **`runner_port`** *(Optional)*: The SSH port number for the target machine. Default is typically `22`, but it can vary depending on your server configuration.

- **`runner_user`** *(Optional)*: The SSH username for logging into the target machine.

- **`runner_password`** *(Optional)*: The password associated with the SSH user. This is only needed if password-based SSH authentication is used instead of key-based authentication.

- **`GITHUB_USER_OR_ORG`** *(Mandatory)*: Your GitHub username or the name of the organization under which the repository exists.

- **`REPO_NAME`** *(Mandatory)*: The name of the GitHub repository where the CI/CD workflow will be integrated.

- **`PERSONAL_ACCESS`** *(Mandatory)*: Your GitHub personal access token, which is required for authenticating API requests.

- **`runner_type`** *(Mandatory)*: The type of runner to deploy. It can be `self-hosted` if you're using your own server or `github-hosted` if you are using GitHub's provided runners.

# Aknowledgements

[Coder]

<a href="https://github.com/Vortex5Root">
    <div style="display: flex; justify-content: center; align-items: center; height: 100px; width: 450px;">
        <img src=https://avatars.githubusercontent.com/u/102427260?s=200&v=4 width=50 style="border-radius: 50%;">
        <a href="https://github.com/Vortex5Root">Vortex5Root <br><b>        {Full-Stack Software Engineer}</b></a>
    </div>
</a><br>

[Contributor]

<a href="https://github.com/PandemicOfNukes">
    <div style="display: flex; justify-content: center; align-items: center; height: 100px; width: 450px;">
        <img src=https://avatars.githubusercontent.com/u/59929476?s=200&v=4 width=50 style="border-radius: 50%;">
        <a href="https://github.com/PandemicOfNukes">PandemicOfNukes <br><b>        {Student}</b></a>
    </div>
</a>

# Conclusion
As you can see CI provides a streamlined and efficient way to automate the process of building and deploying software across various GitHub projects. By standardizing the workflow, this tool simplifies CI/CD integration, making it easier to maintain consistency across your repositories.
