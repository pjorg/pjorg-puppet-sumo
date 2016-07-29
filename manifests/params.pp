# sumo::params
#
# Default values for parameters used in the module.
#
class sumo::params {
  case $::osfamily {
    'RedHat': {
      $sumo_package_name   = 'SumoCollector'
      $sumo_service_config  = '/etc/sumo.conf'
      $sumo_service_name  = 'collector'
      $syncSources    = '/etc/sumo.sources.d'
    }
    'Debian': {
      $sumo_package_name   = 'SumoCollector'
      $sumo_service_config  = '/etc/sumo.conf'
      $sumo_service_name  = 'collector'
      $syncSources    = '/etc/sumo.sources.d'
    }
    default: {
      fail("Module pjorg-sumo does not support osfamily: ${::osfamily}")
    }
  }
  $accessid = undef
  $accesskey = undef
  $clobber = undef
  $collectorName = undef
  $email = undef
  $ephemeral = undef
  $purge_sumo_sources_d = false
  $override = undef
  $password = undef
  $proxyHost = undef
  $proxyNtlmDomain = undef
  $proxyPassword = undef
  $proxyPort = undef
  $proxyUser = undef
  $sources = undef
  $run_as_user = undef
  $run_as_userid = undef
}
