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
add_ci -git <GITHUB_USER_OR_ORG> -repo <REPO_NAME> -key <PERSONAL_ACCESS> [Runner-Options]
```
## Options

- **`-h`**: Show this help message.

## Mandatory Options

- **`-git <name>`** or **`--gitname <name>`**: Set the GitHub user or organization name.
- **`-repo <name>`** or **`--reponame <name>`**: Set the repository name.
- **`-key <classic_token>`** or **`--personalaccess <classic_token>`**: Set the personal access token.

## Setup Runner Options

These options are optional and only needed if you are using a self-hosted runner:

- **`-rh <host>`**: Set the runner host *(Optional)*.
- **`-rp <port>`**: Set the runner port *(Optional)*.
- **`-ru <user>`**: Set the runner user *(Optional)*.
- **`-rpw <password>`**: Set the runner password *(Optional)*.
- **`--update`**: Update the CI tools *(Optional)*.

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
