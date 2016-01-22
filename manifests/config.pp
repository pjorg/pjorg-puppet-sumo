#
#
#
class sumo::config {
  include sumo::params
  file { $::sumo::params::sumo_service_config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/sumo/sumo.conf',
    require => Class['sumo::install'],
    notify  => Class['sumo::service'],
  }
  file { $::sumo::params::log_sync_dir:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  sumo::localfilesource {'myLocalFileSource':
    sourceName     => 'myLocalFileSourceName',
    pathExpression => '/var/log/notareallog.log',
    filters        => ['filter1','filter2']
  }
}
