# sumo::install
#
# Performs package installation of the collector package.
# This class assumes the package is avaialble to the platform's
# native package management tool.
#
class sumo::install {

  package { $::sumo::params::sumo_package_name:
    ensure  => present,
  }
}
