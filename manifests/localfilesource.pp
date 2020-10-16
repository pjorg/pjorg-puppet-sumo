# sumo::localfilesource
#
# Creates a local file source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::localfilesource (
  $pathexpression,
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
  $cutoffrelativetime         = undef,
  $defaultdateformat          = undef,
  $filters                    = undef,
  $blacklist                  = undef,
  $encoding                   = undef,
) {

  include ::sumo
  include ::sumo::params

  $sourcetype = 'LocalFile'
  $syncsources  = $::sumo::syncsources

  file { "${syncsources}/${name}.json":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/localfilesource.json.erb"),
    notify  => Service[$::sumo::params::sumo_service_name],
  }
}
