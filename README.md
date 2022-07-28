# PostgreSQL Proxy over SSH GitHub Action

This GitHub Action creates a proxy for PostgreSQL over SSH

The base-image (drinternet/rsync) of this action is very small and is based on Alpine 3.15.0 (no cache) which results in fast deployments.

---

## Inputs

- `postgre_host` - The PostgreSQL server hostname or IP

- `postgre_port` - The PostgreSQL server port

- `remote_host`* - The remote SSH hostname or IP

- `remote_port` - The remote SSH port. Defaults to 22

- `remote_user`* - The remote SSH username

- `remote_key`* - The remote SSH keyfile

- `remote_key_pass` - The remote SSH keyfile passphrase (if any)

- `switches` - Extra OpenSSH client flags/switches, eg: `-A`

``* = Required``

## Required secret(s)

This action needs secret variables for the SSH private key of your key pair. The public key part should be added to the authorized_keys file on the server that receives the deployment. The secret variable should be set in the Github secrets section of your org/repo and then referenced as the  `remote_key` input.

> Always use secrets when dealing with sensitive inputs!

For simplicity, we are using `DEPLOY_*` as the secret variables throughout the examples.

## Example usage

Simple:

```
name: DEPLOY
on:
  push:
    branches:
    - master

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Setup PostgreSQL proxy
      uses: virbyte/postgresql-proxy-action
      with:
        remote_host: example.com
        remote_user: username
        remote_key: ${{ secrets.DEPLOY_KEY }}
```

Advanced:

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Setup PostgreSQL proxy
      uses: burnett01/rsync-deployments@5.2
      with:
        postgre_host: localhost
        postgre_port: 5432
        remote_host: example.com
        remote_port: 2222
        remote_user: username
        remote_key: ${{ secrets.DEPLOY_KEY }}
```

For better **security**, I suggest you create additional secrets for remote_host, remote_port, remote_user and remote_path inputs.

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: rsync deployments
      uses: burnett01/rsync-deployments@5.2
      with:
        switches: -avzr --delete
        path: src/
        remote_path: ${{ secrets.DEPLOY_PATH }}
        remote_host: ${{ secrets.DEPLOY_HOST }}
        remote_port: ${{ secrets.DEPLOY_PORT }}
        remote_user: ${{ secrets.DEPLOY_USER }}
        remote_key: ${{ secrets.DEPLOY_KEY }}
```

If your private key is passphrase protected you should use:

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: rsync deployments
      uses: burnett01/rsync-deployments@5.2
      with:
        switches: -avzr --delete
        path: src/
        remote_path: ${{ secrets.DEPLOY_PATH }}
        remote_host: ${{ secrets.DEPLOY_HOST }}
        remote_port: ${{ secrets.DEPLOY_PORT }}
        remote_user: ${{ secrets.DEPLOY_USER }}
        remote_key: ${{ secrets.DEPLOY_KEY }}
        remote_key_pass: ${{ secrets.DEPLOY_KEY_PASS }}
```

---

## Acknowledgements

+ This project is a fork of [Burnet01/rsync-deployments](https://github.com/Burnet01/rsync-deployments)
+ Base image [JoshPiper/rsync-docker](https://github.com/JoshPiper/rsync-docker)

---
