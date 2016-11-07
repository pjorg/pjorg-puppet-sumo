# sumo::remotefilesource
#
# Creates a remote file source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::remotefilesource (
  $remotepath,
  $remotehosts,
  $remoteport,
  $remoteuser,
  $authmethod,
  $ensure                     = present,
  $sourcename                 = $title,
  $description                = undef,
  $category                   = undef,
  $hostname                   = undef,
  $timezone                   = undef,
  $automaticdateparsing       = undef,
  $multilineprocessingenabled = undef,
  $useautolinematching        = undef,
  $manualprefixregexp         = undef,
  $forcetimezone              = undef,
  $defaultdateformat          = undef,
  $filters                    = undef,
  $blacklist                  = undef,
  $remotepassword             = undef,
  $keypath                    = undef,
  $keypassword                = undef,
) {

  include ::sumo

  $sourcetype = 'RemoteFile'
  $syncsources  = $::sumo::syncsources

  if (downcase($authmethod) == 'password') {
    if ($remotepassword == undef) {
      fail('To use password authentication for a remote file source, you must pass a value to remotePassword.')
    } elsif ($keypath != undef or $keypassword != undef) {
      warn('If you are using password authentication for a remote file source, do not pass a keyPath or keyPassword.')
    }
  } elsif (downcase($authmethod) == 'key') {
    if ($keypath == undef) {
      fail('To use key authentication for a remote file source, you must set the path to the key in keyPath.')
    } elsif ($remotepassword != undef) {
      warn('If you are using key authentication for a remote file source, do not pass a remotePassword.')
    }
  }

  file { "${syncsources}/${name}.json":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/remotefilesource.json.erb"),
    notify  => Service[$::sumo::params::sumo_service_name],
  }
}
