#
#
#
class sumo::config {
  include sumo::params
  
  sumo::conf {'/etc/sumo.conf':
    accessid  => 'accessid123',
    accesskey => 'accesskey12',
    proxyHost => 'sumoproxy.lab2.local',
    proxyPort => '8080',
    syncSources => $::sumo::params::log_sync_dir,
  }

  file { $::sumo::params::sumo_service_config:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    source  => 'puppet:///modules/sumo/sumo.conf',
    require => Class['sumo::install'],
    notify  => Class['sumo::service'],
  }

  sumo::localfilesource {'myLocalFileSource':
    sourceName     => 'myLocalFileSourceName',
    pathExpression => '/var/log/notareallog.log',
    filters        => ['filter1','filter2'],
    automaticDateParsing => true,
    blacklist      => ['blacklist1','blacklist2']
  }
}
