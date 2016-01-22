#
#
#
define sumo::localfilesource (
  $sourceName,
  $description = undef,
  $category = undef,
  $hostName = undef,
  $timeZone = undef,
  $sourceType = undef,
  $automaticDateParsing = undef,
  $multilineProcessingEnabled = undef,
  $useAutolineMatching = undef,
  $manualPrefixRegexp = undef,
  $forceTimeZone = undef,
  $defaultDateFormat = undef,
  $filters = undef,
  $pathExpression = undef,
  $blacklist = undef,
  $encoding = undef,
) {
  include sumo
  include sumo::params

  $log_sync_dir  = $sumo::params::log_sync_dir

  file { "${log_sync_dir}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => 'this is the content'
  }
}

