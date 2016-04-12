# sumo::remotefilesource
#
# Creates a remote file source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::remotefilesource (
  $remotePath,
  $remoteHosts,
  $remotePort,
  $remoteUser,
  $authMethod,
  $ensure = present,
  $sourceName = $title,
  $description = undef,
  $category = undef,
  $hostName = undef,
  $timeZone = undef,
  $automaticDateParsing = undef,
  $multilineProcessingEnabled = undef,
  $useAutolineMatching = undef,
  $manualPrefixRegexp = undef,
  $forceTimeZone = undef,
  $defaultDateFormat = undef,
  $filters = undef,
  $blacklist = undef,
  $remotePassword = undef,
  $keyPath = undef,
  $keyPassword = undef,
) {
  include sumo

  $sourceType = 'RemoteFile'
  $syncSources  = $::sumo::syncSources

  if (downcase($authMethod) == 'password') {
    if ($remotePassword == undef) {
      fail('To use password authentication for a remote file source, you must pass a value to remotePassword.')
    } elsif ($keyPath != undef or $keyPassword != undef) {
      warn('If you are using password authentication for a remote file source, do not pass a keyPath or keyPassword.')
    }
  } elsif (downcase($authMethod) == 'key') {
    if ($keyPath == undef) {
      fail('To use key authentication for a remote file source, you must set the path to the key in keyPath.')
    } elsif ($remotePassword != undef) {
      warn('If you are using key authentication for a remote file source, do not pass a remotePassword.')
    }
  }

  file { "${syncSources}/${name}.json":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/remotefilesource.json.erb"),
    notify  => Service[$::sumo::params::sumo_service_name],
  }
}

