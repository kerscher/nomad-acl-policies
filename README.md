# Nomad ACL policies

This repository has a collection of policies for use in ACL-enabled Nomad agents.

```shell
$ git clone git@github.com:kerscher/nomad-acl-policies
$ cd nomad-acl-policies
$ make
```

Then to install on your cluster, assuming you have a `management` token available:

```shell
$ export NOMAD_TOKEN="some-management-token"
$ export NOMAD_SERVER="https://some-ip:some-port"
$ make install
```
