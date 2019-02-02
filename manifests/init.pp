# == Class: sumo
#
# This class initializes the module by calling subclasses that ensure the
# package is installed and the sumo.conf file exists.
#
# === Parameters
#
# The parameters of this class mirror those that are used in the sumo.conf
# file. Additional information on what these parameters do can be found in
# the Sumo Logic documentation of the sumo.conf configuration file.
#
# [*accessid*]
#   Specify the accessid to use to authenticate to the Sumo Logic service.
#   If you use this parameter, you must also pass an accesskey, and you
#   must NOT pass email or password.
#
# [*accesskey*]
#   Specify the accesskey to use to authenticate to the Sumo Logic service.
#   If you use this parameter, you must also pass an accessid, and you
#   must NOT pass email or password.
#
# [*clobber*]
#   A boolean indicating whether to clobber the an existing collector with
#   the same name.
#
# [*collectorname*]
#   The name of the collector. Defaults to the hostname.
#
# [*email*]
#   Specify the email address of the account to use to authenticate to the
#   Sumo Logic service. If you use this parameter, you must also pass a
#   password, and you must NOT pass accessid or accesskey.
#
# [*ephemeral*]
#   A boolean indicating whether the collector should be deleted automatically
#   after being offline for 12 hours.
#
# [*purge_sumo_sources_d*]
#   Boolean indicating if /etc/sumo.sources.d should be managed. If true, it
#   will enable purging so files not managed by Puppet will be removed. Default
#   is false.
#
# [*override*]
#   A boolean indicating whether the collector should delete existing log
#   sources amd use only what is described in the sources parameter.
#
# [*password*]
#   Specify the password of the account to use to authenticate to the
#   Sumo Logic service. If you use this parameter, you must also pass an
#   email, and you must NOT pass accessid or accesskey.
#
# [*proxyhost*]
#   The host name of a proxy to use to connect to Sumo Logic.
#
# [*proxyntlmdomain*]
#   When using an NTLM proxy, the domain of the user used to authenticate.
#
# [*proxypassword*]
#   The password to use when authenticating to a proxy.
#
# [*proxyport*]
#   The TCP port to connect to the proxy on.
#
# [*proxyuser*]
#   The username to use when authenticating to a proxy.
#
# [*sources*]
#   Path to JSON file that contains Source configuration.
#
# [*syncsources*]
#   The path to a JSON file or a directory containing JSON files with source
#   configurations. This path is continually monitored for changes. By default,
#   the module sets this to a directory and uses this directory to pass source
#   configurations to the collector.
#
# === Examples
#
# A basic example, using username/password and without any sources:
#
# class sumo {
#   email    => 'user@example.com',
#   password => 'usersPassword123!',
# }
#
#
# A more advanced example, using a Sumo accessid and with a local file source:
#
# class sumo {
#   accessid  => 'SumoAccessId',
#   accesskey => 'SumoAccessKey_123ABC/&!',
# }
# sumo::localfilesource { 'messages':
#   sourcename => 'message_log'
#   pathexpression => '/var/log/messages',
# }
#
#
# === Authors
#
# Peter D. Jorgensen <pdjorgensen@gmail.com>
#
# === Copyright
#
# Copyright 2016 Peter D. Jorgensen, unless otherwise noted.
#
class sumo (
  $accessid                   = $::sumo::params::accessid,
  $accesskey                  = $::sumo::params::accesskey,
  $clobber                    = $::sumo::params::clobber,
  $collectorname              = $::sumo::params::collectorname,
  $email                      = $::sumo::params::email,
  $ephemeral                  = $::sumo::params::ephemeral,
  $purge_sumo_sources_d       = $::sumo::params::purge_sumo_sources_d,
  $override                   = $::sumo::params::override,
  $password                   = $::sumo::params::password,
  $proxyhost                  = $::sumo::params::proxyhost,
  $proxyntlmdomain            = $::sumo::params::proxyntlmdomain,
  $proxypassword              = $::sumo::params::proxypassword,
  $proxyport                  = $::sumo::params::proxyport,
  $proxyuser                  = $::sumo::params::proxyuser,
  $sources                    = $::sumo::params::sources,
  $syncsources                = $::sumo::params::syncsources,
  $syncsourceswithsinglejson  = $::sumo::params::syncsourceswithsinglejson,
  $serviceconfig              = $::sumo::params::sumo_service_config,
) inherits sumo::params {

  include ::sumo::params, ::sumo::install, ::sumo::config, ::sumo::service

  validate_bool($purge_sumo_sources_d)
}
