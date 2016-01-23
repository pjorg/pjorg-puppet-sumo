# pjorg-sumo

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sumo](#setup)
    * [What sumo affects](#what-sumo-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with sumo](#beginning-with-sumo)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module installs and configures the Sumo Logic collector agent on a node, 
and also places source configuration under Puppet management. It also is
designed to work with existing package managment rather than relying on
downloading binaries directly from the Sumo Logic service and running the
installer.

## Module Description

The Sumo Logic collector is a small agent that is installed on hosts that
facilitates the ingestion of log data into the Sumo Logic service.

There are a number of ways to install this agent. This module is intended for
use cases where native package management solutions are preferred over running
an installer. Initial support is limited to the `RedHat` OS family, which uses
RPM packages.

Additionally, there is support for managing log sources within a node's
manifest. This may be useful for ensuring that all nodes of a specific class
always have certain log files collected.

## Setup

### What sumo affects

* Installs the SumoCollector package via `yum`
* Creates the `sumo.conf` file to allow for initial collector setup
* Creates a source sync directory and manages JSON files within it, which
  controls a collector's active log sources (this disables source management
  from within the Sumo Logic UI)

### Beginning with sumo

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps
for upgrading, you may wish to include an additional section here: Upgrading
(For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing
the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
This section should include all of the under-the-hood workings of your module so
people know what the module is touching on their system but don't need to mess
with things. (We are working on automating this section!)

## Limitations

Presently this module only supports the RHEL family of operating systems. All 
testing has been done on CentOS 6.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You may also add any additional sections you feel are
necessary or important to include here. Please use the `## ` header.
