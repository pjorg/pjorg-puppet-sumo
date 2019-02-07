# pjorg-puppet-sumo

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What sumo affects](#what-sumo-affects)
    * [Beginning with sumo](#beginning-with-sumo)
4. [Development](#development)

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

Before starting, you must make the collector RPM available to your hosts' package
management. For RedHat-family operating systems, this means that 
`yum install SumoCollector` should work. If it does not, this module will not 
function.

After that, a basic collector instance can be installed and configured by
including the `sumo` class in a node's manifest, and passing credentials to
be used to attach the collector to your Sumo Logic account.

A basic example, using username/password and without any sources:

~~~puppet
node mynode.lab.local {
  class sumo {
    email    => 'user@example.com',
    password => 'usersPassword123!', 
  }
}
~~~  

Second basic example, using username/password with single source json file:

~~~puppet
node mynode.lab.local {
  class { 'sumo':
    email                     => 'user@example.com',
    password                  => 'usersPassword123!', 
    syncsourceswithsinglejson => '/path/to/file.json', 
  }
}
~~~  

A more advanced example, using a Sumo accessid and with a local file source:

~~~puppet
node mynode.lab.local {
  class sumo {
    accessid  => 'SumoAccessId',
    accesskey => 'SumoAccessKey_123ABC/&!',
  }

  sumo::localfilesource { 'messages':
    sourceName => 'message_log'
    pathExpression => '/var/log/messages',
  }
}
~~~  


## Development

Contributions expanding the module to use other portions of the Sumo Logic API
and/or extending support to other platforms are welcome.

Development targets the latest releases of Puppet versions 5 and 6. See
`.travis.yml` for an exact matrix.
