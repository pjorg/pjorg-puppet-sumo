# sumo::run_as_user
#
# This will override the init script for sumologic and run as a particular user
#
class sumo::run_as_user
{
  include sumo

  group { $sumo::run_as_user:
    ensure => present,
    gid    => $sumo::run_as_userid,
  }

  user { $sumo::run_as_user:
    ensure     => present,
    home       => "/home/${sumo::run_as_user}",
    gid        => $sumo::run_as_userid,
    uid        => $sumo::run_as_userid,
    managehome => true,
    require    => Group[$sumo::run_as_user],
  }

  exec { 'stop-sumo':
    path    => ['/usr/bin', '/usr/sbin', '/bin', '/sbin'],
    command => "service ${::sumo::params::sumo_service_name} stop",
    onlyif  => [
              "test $(stat -c %U /proc/$(cat /opt/SumoCollector/collector.pid) | grep -c 'root') -eq 1",
              "service ${::sumo::params::sumo_service_name} status"
              ],
    require => Class['sumo::install'],
  }

  file { '/opt/SumoCollector/collector':
    mode    => '0755',
    owner   => $sumo::run_as_user,
    group   => $sumo::run_as_user,
    content => template('sumo/collector.erb'),
    require => [ User[$sumo::run_as_user], Group[$sumo::run_as_user], Exec['stop-sumo'] ],
  }

  file { '/opt/SumoCollector':
    ensure  => directory,
    owner   => $sumo::run_as_user,
    group   => $sumo::run_as_user,
    require => [ File['/opt/SumoCollector/collector'] ],
    recurse => true,
    notify  => Class['sumo::service'],
  }

}
