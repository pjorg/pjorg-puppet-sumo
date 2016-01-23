#
#
#
class sumo::config {
  sumo::conf {'sumo.conf':
    accessid        => $::sumo::accessid,
    accesskey       => $::sumo::accesskey,
    clobber         => $::sumo::clobber,
    collectorName   => $::sumo::collectorName,
    email           => $::sumo::email,
    ephemeral       => $::sumo::ephemeral,
    override        => $::sumo::override,
    password        => $::sumo::password,
    proxyHost       => $::sumo::proxyHost,
    proxyNtlmDomain => $::sumo::proxyNtlmDomain,
    proxyPassword   => $::sumo::proxyPassword,
    proxyPort       => $::sumo::proxyPort,
    proxyUser       => $::sumo::proxyUser,
    sources         => $::sumo::sources,
    syncSources     => $::sumo::syncSources,
  }
}
