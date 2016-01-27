# sumo::service
#
# Controls the desired state of the collector service.
#
class sumo::service {
  include sumo
  service { $::sumo::params::sumo_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['sumo::config'],
  }
}
