<h1 align="center">CI</h1>
<p align="center">
    <a href="https://github.com/Vortex5Root/CI/blob/master/LICENSE"><img src="https://img.shields.io/github/license/Vortex5Root/CI.svg" alt="License"></a>
    <a href="https://github.com/Vortex5Root/CI/releases"><img src="https://img.shields.io/github/downloads/Vortex5Root/CI/total.svg" alt="GitHub all releases"></a><br>
    <a href="https://github.com/Vortex5Root/CI/network"><img src="https://img.shields.io/github/forks/Vortex5Root/CI.svg" alt="GitHub forks"></a>
    <a href="https://github.com/Vortex5Root/CI/stargazers"><img src="https://img.shields.io/github/stars/Vortex5Root/CI.svg" alt="GitHub stars"></a>
    <a href="https://github.com/Vortex5Root/CI/watchers"><img src="https://img.shields.io/github/watchers/Vortex5Root/CI.svg" alt="GitHub watchers"></a><br>
    <a href="https://github.com/Vortex5Root/CI/issues"><img src="https://img.shields.io/github/issues/Vortex5Root/CI.svg" alt="GitHub issues"></a>
    <a href="https://github.com/Vortex5Root/CI/pulls"><img src="https://img.shields.io/github/issues-pr/Vortex5Root/CI.svg" alt="GitHub pull requests"></a>
    <a href="https://github.com/Vortex5Root/CI/commits/master"><img src="https://img.shields.io/github/last-commit/Vortex5Root/CI.svg" alt="GitHub last commit"></a>
</p>

## Introduction

> **CI** is a collection of scripts that can be used to automate the process of building and deploying software. It is designed to be used with GitHub Actions, but can be used with other CI/CD services as well.

| Problem | Solution |
| --- | --- |
| **How to integrate the project workflow on every github project?** | **This tool creates a workflow standard for every github project thus facilitating the deployment of the projects.** |

## Index

| topic | sub-topic | 
| --- | --- |
| [Installation](#how-to-install) | |
| | [How to install?](#how-to-install) |
| | [Make Optional](#make-optional) |
| [Usage](#how-to-use) | |
| | [Options](#options) |
| | [Mandatory Options](#mandatory-options) |
| | [Setup Runner Options](#setup-runner-options) |
| [Aknowledgements](#aknowledgements) | |
| | [Coder](#coder) |
| | [Contributor](#contributor) |
| [Conclusion](#conclusion) | |

## Requirements

| Requirement | Version |
| --- | --- |
| ![Debian](https://img.shields.io/badge/Debian-A81D33?style=flat&logo=debian&logoColor=white&style=for-the-badge) | 12.5.0 |

-------
<p align="center">
    <a href="https://www.gnu.org/software/bash/"></a><img src="https://img.shields.io/badge/-Made%20with%20Bash-1f425f.svg?style=for-the-badge&logo=image%2Fpng%3Bbase64%2CiVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw%2FeHBhY2tldCBiZWdpbj0i77u%2FIiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8%2BIDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTExIDc5LjE1ODMyNSwgMjAxNS8wOS8xMC0wMToxMDoyMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTUgKFdpbmRvd3MpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOkE3MDg2QTAyQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOkE3MDg2QTAzQUZCMzExRTVBMkQxRDMzMkJDMUQ4RDk3Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6QTcwODZBMDBBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6QTcwODZBMDFBRkIzMTFFNUEyRDFEMzMyQkMxRDhEOTciLz4gPC9yZGY6RGVzY3JpcHRpb24%2BIDwvcmRmOlJERj4gPC94OnhtcG1ldGE%2BIDw%2FeHBhY2tldCBlbmQ9InIiPz6lm45hAAADkklEQVR42qyVa0yTVxzGn7d9Wy03MS2ii8s%2BeokYNQSVhCzOjXZOFNF4jx%2BMRmPUMEUEqVG36jo2thizLSQSMd4N8ZoQ8RKjJtooaCpK6ZoCtRXKpRempbTv5ey83bhkAUphz8fznvP8znn%2B%2F3NeEEJgNBoRRSmz0ub%2FfuxEacBg%2FDmYtiCjgo5NG2mBXq%2BH5I1ogMRk9Zbd%2BQU2e1ML6VPLOyf5tvBQ8yT1lG10imxsABm7SLs898GTpyYynEzP60hO3trHDKvMigUwdeaceacqzp7nOI4n0SSIIjl36ao4Z356OV07fSQAk6xJ3XGg%2BLCr1d1OYlVHp4eUHPnerU79ZA%2F1kuv1JQMAg%2BE4O2P23EumF3VkvHprsZKMzKwbRUXFEyTvSIEmTVbrysp%2BWr8wfQHGK6WChVa3bKUmdWou%2BjpArdGkzZ41c1zG%2Fu5uGH4swzd561F%2BuhIT4%2BLnSuPsv9%2BJKIpjNr9dXYOyk7%2FBZrcjIT4eCnoKgedJP4BEqhG77E3NKP31FO7cfQA5K0dSYuLgz2TwCWJSOBzG6crzKK%2BohNfni%2Bx6OMUMMNe%2Fgf7ocbw0v0acKg6J8Ql0q%2BT%2FAXR5PNi5dz9c71upuQqCKFAD%2BYhrZLEAmpodaHO3Qy6TI3NhBpbrshGtOWKOSMYwYGQM8nJzoFJNxP2HjyIQho4PewK6hBktoDcUwtIln4PjOWzflQ%2Be5yl0yCCYgYikTclGlxadio%2BBQCSiW1UXoVGrKYwH4RgMrjU1HAB4vR6LzWYfFUCKxfS8Ftk5qxHoCUQAUkRJaSEokkV6Y%2F%2BJUOC4hn6A39NVXVBYeNP8piH6HeA4fPbpdBQV5KOx0QaL1YppX3Jgk0TwH2Vg6S3u%2BdB91%2B%2FpuNYPYFl5uP5V7ZqvsrX7jxqMXR6ff3gCQSTzFI0a1TX3wIs8ul%2Bq4HuWAAiM39vhOuR1O1fQ2gT%2F26Z8Z5vrl2OHi9OXZn995nLV9aFfS6UC9JeJPfuK0NBohWpCHMSAAsFe74WWP%2BvT25wtP9Bpob6uGqqyDnOtaeumjRu%2ByFu36VntK%2FPA5umTJeUtPWZSU9BCgud661odVp3DZtkc7AnYR33RRC708PrVi1larW7XwZIjLnd7R6SgSqWSNjU1B3F72pz5TZbXmX5vV81Yb7Lg7XT%2FUXriu8XLVqw6c6XqWnBKiiYU%2BMt3wWF7u7i91XlSEITwSAZ%2FCzAAHsJVbwXYFFEAAAAASUVORK5CYII%3D" alt="Bash"></a><br><br>
    <h2 align="center">How to install?</h2>
</p>

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
make install
```

Note: After running `make install`, you may need to run `source ~/.bashrc`.

### Make Optional:
```bash
make [target]
```
- **`target`**: The target to execute. Available targets are:
    - `install`: Install the CI tool.
    - `update`: Update the CI tool.
    - `uninstall`: Uninstall the CI tool.
    - `rebase_project`: Rebase the CI tool.
    - `help`: Display the help message.

-------

<p align="center">
    <a href="#how-to-use"><img src="https://img.shields.io/badge/wiki.js-%231976D2.svg?style=for-the-badge&logo=wikidotjs&logoColor=white"></a><br><br>
    <h2 align="center">How to use ?</h2>
</p>

```bash
add_ci -git <GITHUB_USER_OR_ORG> -repo <REPO_NAME> -key <PERSONAL_ACCESS> [Runner-Options]
```
### Options

- **`-h`**: Show this help message.

### Mandatory Options

- **`-git <name>`** or **`--gitname <name>`**: Set the GitHub user or organization name.
- **`-repo <name>`** or **`--reponame <name>`**: Set the repository name.
- **`-key <classic_token>`** or **`--personalaccess <classic_token>`**: Set the personal access token.

### Setup Runner Options

These options are optional and only needed if you are using a self-hosted runner:

- **`-rh <host>`**: Set the runner host *(Optional)*.
- **`-rp <port>`**: Set the runner port *(Optional)*.
- **`-ru <user>`**: Set the runner user *(Optional)*.
- **`-rpw <password>`**: Set the runner password *(Optional)*.
- **`--update`**: Update the CI tools *(Optional)*.

-------

## Aknowledgements

<p align="center">
    <br>[Coder]<br>
    <a href="https://github.com/Vortex5Root"><img src=https://avatars.githubusercontent.com/u/102427260?s=200&v=4 width=50 style="border-radius: 50%;"><br>Vortex5Root <br><b>        {Full-Stack Software Engineer}</b></a><br>
    <br>[Contributor]<br>
    <a href="https://github.com/PandemicOfNukes"><img src=https://avatars.githubusercontent.com/u/59929476?s=200&v=4 width=50 style="border-radius: 50%;"><br>PandemicOfNukes <br><b>        {Student}</b></a><br><br>
</p>

## Conclusion
As you can see CI provides a streamlined and efficient way to automate the process of building and deploying software across various GitHub projects. By standardizing the workflow, this tool simplifies CI/CD integration, making it easier to maintain consistency across your repositories.
