#
#
#
define sumo::remotefilesource (
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
  $pathExpression,
  $blacklist = undef,
  $remoteHosts,
  $remotePort,
  $remoteUser,
  $remotePassword = undef,
  $keyPath = undef,
  $keyPassword = undef,
  $authMethod,
) {
  include sumo

  $sourceType = 'RemoteFile'
  $syncSources  = $::sumo::syncSources

  if ($authMethod.downcase == 'password') {
    if ($remotePassword == undef) {
      fail('To use password authentication for a remote file source, you must pass a value to remotePassword.')
    } elsif ($keyPath != undef or $keyPassword != undef) {
      warn('If you are using password authentication for a remote file source, don't pass a keyPath or keyPassword.')
    }
  } elsif ($authMethod.downcase == 'key') {
    if ($keyPath == undef) {
      fail('To use key authentication for a remote file source, you must set the path to the key in keyPath.')
    } elsif ($remotePassword != undef) {
      warn('If you are using key authentication for a remote file source, don't pass a remotePassword.')
    }
  }

  file { "${syncSources}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/remotefilesource.json.erb"),
  }
}

