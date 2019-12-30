# Git Sync

A GitHub Action for syncing between two independent repositories using **force push**. 


## Features
 * Sync branches between two GitHub repositories
 * Sync branches to/from a remote repository
 * GitHub action can be triggered on a timer or on push
 * To sync with current repository, please checkout [Github Repo Sync](https://github.com/marketplace/actions/github-repo-sync)


## Usage

### GitHub Actions
```
# File: .github/workflows/repo-sync.yml

on: push
jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - name: repo-sync
      uses: wei/git-sync@v1
      env:
        SOURCE_REPO: ""
        SOURCE_BRANCH: ""
        DESTINATION_REPO: ""
        DESTINATION_BRANCH: ""
        SSH_PRIVATE_KEY: ${{ secrets.SSH_PRIVATE_KEY }}
        SSH_PRIVATE_KEY_DESTINATION: ${{ secrets.SSH_PRIVATE_KEY }}
      with:
        args: $SOURCE_REPO $SOURCE_BRANCH $DESTINATION_REPO $DESTINATION_BRANCH
```
1. `SSH_PRIVATE_KEY` can be omitted if using authenticated HTTPS repo clone urls like `https://username:access_token@github.com/username/repository.git`.
1. `SSH_PRIVATE_KEY_DESTINATION` can be omitted. If the env is ommited and `SSH_PRIVATE_KEY` is set, then the env will be set to the value of `SSH_PRIVATE_KEY`.

#### Advanced: Sync all branches

To Sync all branches from source to destination, use `SOURCE_BRANCH: "refs/remotes/source/*"` and `DESTINATION_BRANCH: "refs/heads/*"`. But be careful, branches with the same name including `master` will be overwritten.

### Docker
```
docker run --rm -e "SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)" $(docker build -q .) \
  $SOURCE_REPO $SOURCE_BRANCH $DESTINATION_REPO $DESTINATION_BRANCH
```

## Author
[Wei He](https://github.com/wei) _github@weispot.com_


## License
[MIT](https://wei.mit-license.org)
