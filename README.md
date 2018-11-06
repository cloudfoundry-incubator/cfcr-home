# CFCR Home
The repo where you feel at home.

This contains configuration to set up a Mac workstation and tools for developing
[CFCR](https://github.com/cloudfoundry-incubator/kubo-release).

## Setup your workstation
Run `./setup.sh` to have all tools and dependencies installed.
You can get more info and customise the workstation in the configuration files
of the main folder.

## Featured tools

A highlight of some of the available scripts (also added in the path):
* `set-bosh-env` takes a BOSH creds file and sets environment variable to target a director.
* `set-story` allows to set the tracker story id to be used in commit
  messages instead of manually setting it every time.
* `sync-jumpbox` accesses LastPass to add identities for the team jumpboxes to
  the ssh config file.
* `claim`, `unclaim` and `recycle` can be used to manually
  claim, unclaim and recycle environment locks
* `load-personal-keys` and `set-git-keys` are used to load github personal ssh keys. They need to be set up in slightly different ways.
* `local-kubo-ci` sets up an environment folder in `/tmp` to easily access a CI
  environment from the local machine.
* `blup` deploys a BOSH director locally in a virtualbox VM.
