# sumo::syslogsource
#
# Creates a syslog source for the collector to ingest from.
# This is done by creating a JSON file under the syncSources directory
# that is configured in sumo.conf.
#
define sumo::syslogsource (
  $protocol,
  $port,
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
) {

  include ::sumo

  $sourcetype = 'Syslog'
  $syncsources  = $::sumo::syncsources

  file { "${syncsources}/${name}.json":
    ensure  => $ensure,
    owner   => $::sumo::owner,
    group   => $::sumo::group,
    mode    => '0600',
    content => template("${module_name}/syslogsource.json.erb"),
    notify  => Service[$::sumo::params::sumo_service_name],
  }
}
