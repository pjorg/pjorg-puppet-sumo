#
#
#
class sumo::config {
  include sumo::params
  
  sumo::conf {'sumo.conf':
    accessid => $::sumo::accessid
    accesskey => $::sumo::accesskey
    clobber => $::sumo::clobber
    collectorName => $::sumo::collectorName
    email => $::sumo::email
    ephemeral => $::sumo::ephemeral
    override => $::sumo::override
    password => $::sumo::password
    proxyHost => $::sumo::proxyHost
    proxyNtlmDomain => $::sumo::proxyNtlmDomain
    proxyPassword => $::sumo::proxyPassword
    proxyPort => $::sumo::proxyPort
    proxyUser => $::sumo::proxyUser
    sources => $::sumo::sources
    syncSources => $::sumo::syncSources
  }

  file { $::sumo::params::syncSources:
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
