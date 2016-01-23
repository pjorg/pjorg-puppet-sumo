#
#
#
define sumo::syslogsource (
  $sourceName,
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
  $protocol = undef,
  $port,
) {
  include sumo

  $sourceType = 'Syslog'
  $syncSources  = $::sumo::syncSources

  file { "${syncSources}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/syslogsource.json.erb"),
  }
}