define sumo::localFileSource (
  $sourceName,
  $description,
  $category,
  $hostName,
  $timeZone,
  $sourceType,
  $automaticDateParsing,
  $multilineProcessingEnabled,
  $useAutolineMatching,
  $manualPrefixRegexp,
  $forceTimeZone,
  $defaultDateFormat,
  $filters,
  $pathExpression,
  $blacklist,
  $encoding,
) {
  include sumo
  include sumo::params

  $log_sync_dir  = $sumo::params::log_sync_dir
  $name    = $sourceName.gsub(/\s+/, '')

  file { "${log_sync_dir}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => 'this is the content'
  }
}

