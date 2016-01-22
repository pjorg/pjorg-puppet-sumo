#
#
#
class sumo::install {
  package { $::sumo::params::sumo_package_name:
    ensure  => present,
  }
}
