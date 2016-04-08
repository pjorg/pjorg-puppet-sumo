# sumo::syslogsource
#
# Creates a syslog source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::syslogsource (
  $protocol,
  $port,
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
) {
  include sumo

  $sourceType = 'Syslog'
  $syncSources  = $::sumo::syncSources

  file { "${syncSources}/${name}.json":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/syslogsource.json.erb"),
    notify  => Service[$::sumo::params::sumo_service_name],
  }
}
