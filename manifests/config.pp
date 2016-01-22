#
#
#
class sumo::config {
  include sumo::params
  
  sumo::conf {'sumo.conf':
    accessid  => 'accessid123',
    accesskey => 'accesskey12',
    proxyHost => 'sumoproxy.lab2.local',
    proxyPort => '8080',
    syncSources => $::sumo::params::log_sync_dir,
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
    filters        => ['filter1','filter2'],
    automaticDateParsing => true,
    blacklist      => ['blacklist1','blacklist2']
  }
}
