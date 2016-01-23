#
#
#
class sumo (
  $accessid = $::sumo::params::accessid,
  $accesskey = $::sumo::params::accesskey,
  $clobber = $::sumo::params::clobber,
  $collectorName = $::sumo::params::collectorName,
  $email = $::sumo::params::email,
  $ephemeral = $::sumo::params::ephemeral,
  $override = $::sumo::params::override,
  $password = $::sumo::params::password,
  $proxyHost = $::sumo::params::proxyHost,
  $proxyNtlmDomain = $::sumo::params::proxyNtlmDomain,
  $proxyPassword = $::sumo::params::proxyPassword,
  $proxyPort = $::sumo::params::proxyPort,
  $proxyUser = $::sumo::params::proxyUser,
  $sources = $::sumo::params::sources,
  $syncSources = $::sumo::params::syncSources,
) {
  include sumo::params, sumo::install, sumo::config, sumo::service
}
