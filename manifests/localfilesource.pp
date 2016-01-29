# sumo::localfilesource
#
# Creates a local file source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::localfilesource (
  $pathExpression,
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
  $encoding = undef,
) {
  include sumo
  include sumo::params

  $sourceType = 'LocalFile'
  $syncSources  = $::sumo::syncSources

  file { "${syncSources}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/localfilesource.json.erb"),
  }
}

