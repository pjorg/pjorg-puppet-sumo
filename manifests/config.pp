# sumo::config
#
# This class performs all configuration actions for the collector package.
#
class sumo::config {

  include ::sumo::config

  sumo::conf { 'sumo.conf':
    accessid        => $::sumo::accessid,
    accesskey       => $::sumo::accesskey,
    clobber         => $::sumo::clobber,
    collectorname   => $::sumo::collectorname,
    email           => $::sumo::email,
    ephemeral       => $::sumo::ephemeral,
    override        => $::sumo::override,
    password        => $::sumo::password,
    proxyhost       => $::sumo::proxyhost,
    proxyntlmdomain => $::sumo::proxyntlmdomain,
    proxypassword   => $::sumo::proxypassword,
    proxyport       => $::sumo::proxyport,
    proxyuser       => $::sumo::proxyuser,
    sources         => $::sumo::sources,
    syncsources     => $::sumo::syncsources,
  }
}
