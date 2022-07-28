# PostgreSQL Proxy over SSH GitHub Action

This GitHub Action creates a proxy for PostgreSQL over SSH

The base-image (drinternet/rsync) of this action is very small and is based on Alpine 3.15.0 (no cache) which results in fast deployments.

from Burnett01/rsync-deployments:

---

## Inputs

- `switches`* - The first is for any initial/required rsync flags, eg: `-avzr --delete`

- `rsh` - Remote shell commands

- `path` - The source path. Defaults to GITHUB_WORKSPACE

- `remote_path`* - The deployment target path

- `remote_host`* - The remote host

- `remote_port` - The remote port. Defaults to 22

- `remote_user`* - The remote user

- `remote_key`* - The remote ssh key

- `remote_key_pass` - The remote ssh key passphrase (if any)

``* = Required``

## Required secret(s)

This action needs secret variables for the ssh private key of your key pair. The public key part should be added to the authorized_keys file on the server that receives the deployment. The secret variable should be set in the Github secrets section of your org/repo and then referenced as the  `remote_key` input.

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
    - name: rsync deployments
      uses: burnett01/rsync-deployments@5.2
      with:
        switches: -avzr --delete
        path: src/
        remote_path: /var/www/html/
        remote_host: example.com
        remote_user: debian
        remote_key: ${{ secrets.DEPLOY_KEY }}
```

Advanced:

```
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: rsync deployments
      uses: burnett01/rsync-deployments@5.2
      with:
        switches: -avzr --delete --exclude="" --include="" --filter=""
        path: src/
        remote_path: /var/www/html/
        remote_host: example.com
        remote_port: 5555
        remote_user: debian
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

## Version 4.0 & 4.1

Looking for version 4.0 and 4.1?

Check here: 

- https://github.com/Burnett01/rsync-deployments/tree/4.0
- https://github.com/Burnett01/rsync-deployments/tree/4.1

Version 4.0 & 4.1 use the ``drinternet/rsync:1.0.1`` base-image.

---

## Version 3.0 (EOL)

Looking for version 3.0?

Check here: https://github.com/Burnett01/rsync-deployments/tree/3.0

Version 3.0 uses the ``alpine:latest`` base-image directly.<br>
Consider upgrading to 4.0 that uses a docker-image ``drinternet/rsync:1.0.1`` that is<br>
based on ``alpine:latest``and heavily optimized for rsync.

## Version 2.0 (EOL)

Looking for version 2.0?

Check here: https://github.com/Burnett01/rsync-deployments/tree/2.0

Version 2.0 uses a larger base-image (``ubuntu:latest``).<br>
Consider upgrading to 3.0 for even faster deployments.

## Version 1.0 (EOL)

Looking for version 1.0?

Check here: https://github.com/Burnett01/rsync-deployments/tree/1.0

Please note that version 1.0 has reached end of life state.

---

## Acknowledgements

+ This project is a fork of [Contention/rsync-deployments](https://github.com/Contention/rsync-deployments)
+ Base image [JoshPiper/rsync-docker](https://github.com/JoshPiper/rsync-docker)

---
