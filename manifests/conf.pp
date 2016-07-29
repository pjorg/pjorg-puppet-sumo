# sumo::conf
#
# This class manages the sumo.conf file, which the collector uses to perform 
# initial setup. 
#
define sumo::conf (
  $accessid = undef,
  $accesskey = undef,
  $clobber = undef,
  $email = undef,
  $ephemeral = undef,
  $collectorName = undef,
  $override = undef,
  $password = undef,
  $proxyHost = undef,
  $proxyNtlmDomain = undef,
  $proxyPassword = undef,
  $proxyPort = undef,
  $proxyUser = undef,
  $sources = undef,
  $syncSources = undef,
) {
  include sumo
  
  if ($accessid != undef or $accesskey != undef) and ($email != undef or $password != undef) {
    fail('You must pass either an accessid/accesskey pair or an email/password pair, not both.')
  } elsif (($accessid == undef and $accesskey != undef) or ($accessid != undef and $accesskey == undef)) {
    fail('You must pass both the accessid and accesskey.')
  } elsif (($email == undef and $password != undef) or ($email != undef and $password == undef)) {
    fail('You must pass both the email and password.')
  }

  # The docs aren't clear, but it seems like the config file really wants
  # the syncSources value to end in a slash if it's a directory
  if( $syncSources != undef) {
    if $::sumo::purge_sumo_sources_d == true {
      $syncsources_purge = true
      $syncsources_recurse = true
    } else {
      $syncsources_purge = undef
      $syncsources_recurse = undef
    }

    file { $syncSources:
      ensure  => 'directory',
      owner   => $::sumo::runasuser,
      group   => $::sumo::runasuser,
      mode    => '0755',
      purge   => $syncsources_purge,
      recurse => $syncsources_recurse,
    }
    $syncSourcesWithTrailingSlash = "${syncSources}/"
  } else {
    $syncSourcesWithTrailingSlash = undef
  }

  file { $::sumo::params::sumo_service_config:
    ensure  => present,
    owner   => $::sumo::runasuser,
    group   => $::sumo::runasuser,
    mode    => '0600',
    content => template("${module_name}/sumo.conf.erb"),
    require => Class['sumo::install'],
    notify  => Class['sumo::service'],
  }
}
