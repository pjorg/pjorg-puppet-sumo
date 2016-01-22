#
#
#
define sumo::localfilesource (
  String[1] $sourceName,
  String[1] $description = undef,
  String[1] $category = undef,
  String[1] $hostName = undef,
  String[1] $timeZone = undef,
  Boolean   $automaticDateParsing = undef,
  Boolean   $multilineProcessingEnabled = undef,
  Boolean   $useAutolineMatching = undef,
  String[1] $manualPrefixRegexp = undef,
  Boolean   $forceTimeZone = undef,
  String[1] $defaultDateFormat = undef,
  Array[String]  $filters = undef,
  String[1] $pathExpression,
  Array[String]  $blacklist = undef,
  String[5] $encoding = undef,
) {
  include sumo
  include sumo::params

  $sourceType = 'LocalFile'
  $log_sync_dir  = $sumo::params::log_sync_dir

  file { "${log_sync_dir}/${name}.json":
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/source.json.erb"),
  }
}

