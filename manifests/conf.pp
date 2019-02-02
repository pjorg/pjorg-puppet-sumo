# sumo::conf
#
# This class manages the sumo.conf file, which the collector uses to perform
# initial setup.
#
define sumo::conf (
  $accessid                  = undef,
  $accesskey                 = undef,
  $clobber                   = undef,
  $email                     = undef,
  $ephemeral                 = undef,
  $collectorname             = undef,
  $override                  = undef,
  $password                  = undef,
  $proxyhost                 = undef,
  $proxyntlmdomain           = undef,
  $proxypassword             = undef,
  $proxyport                 = undef,
  $proxyuser                 = undef,
  $sources                   = undef,
  $syncsources               = undef,
  $syncsourceswithsinglejson = undef,
  $serviceconfig             = undef,
) {

  include ::sumo

  if ($accessid != undef or $accesskey != undef) and ($email != undef or $password != undef) {
    fail('You must pass either an accessid/accesskey pair or an email/password pair, not both.')
  } elsif (($accessid == undef and $accesskey != undef) or ($accessid != undef and $accesskey == undef)) {
    fail('You must pass both the accessid and accesskey.')
  } elsif (($email == undef and $password != undef) or ($email != undef and $password == undef)) {
    fail('You must pass both the email and password.')
  }

  # The docs aren't clear, but it seems like the config file really wants
  # the syncSources value to end in a slash if it's a directory
  if( $syncsources != undef) {
    if $::sumo::purge_sumo_sources_d == true {
      $syncsources_purge = true
      $syncsources_recurse = true
    } else {
      $syncsources_purge = undef
      $syncsources_recurse = undef
    }

    file { $syncsources:
      ensure  => 'directory',
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      purge   => $syncsources_purge,
      recurse => $syncsources_recurse,
    }
  }

  if $syncsourceswithsinglejson != undef {
    validate_absolute_path($syncsourceswithsinglejson)
  }

  if ( $syncsourceswithsinglejson != undef) {
      $syncsourceswithtrailingslash = $syncsourceswithsinglejson
    } else {
      $syncsourceswithtrailingslash = "${syncsources}/"
  }

  file { $serviceconfig:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/sumo.conf.erb"),
    require => Class['sumo::install'],
    notify  => Class['sumo::service'],
  }
}
