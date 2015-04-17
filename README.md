# oracleclient

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What oracleclient affects](#what-oracleclient-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oracleclient](#beginning-with-oracleclient)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
7. [Release Notes](#releasenotes)

## Overview

Manage oracle clients with puppet.

## Module Description

The intention of this module is to simplify automated management of the Oracle
client. *Without* the need to custom package the Oracle client for your
operating system of choice.

`oracleclient` will install and manage Oracle client.

## Setup

### What oracleclient affects

* Have a look at the code until I find time to document this properly.

### Setup Requirements

`$installer_source` needs to be the path to an unpacked oracle client, thus,
it should preferably reside on a network share of some sort, as OS specific
packages does not seem to be available.

### Beginning with oracleclient

## Usage

Basic usage:
```puppet
class { 'oracleclient':
  installer_source => '/path/to/nfs/oracle/client',
}
```


### Important parameters

* *installer_source* -- Path to an unzipped Oracle client, containing the file
called `runInstaller`.
* *manage_users* -- Should we set up users? Probably not if you have a central
source for authentication like LDAP. Defaults to ***true***.

## Reference

* *init.pp*
* *install.pp*
* *params.pp*
* *prepare.pp*

## Limitations

So far only tested on CentOS/RHEL 7.

## Development

Plz 2 contribute.

## Release Notes

Placeholder for changelog
