# sumo::hiera
#
# Allow defines to be called by hiera
#
class sumo::hiera {
  $localfilesource = hiera_hash('sumo::localfilesource', undef)
  $remotefilesource = hiera_hash('sumo::remotefilesource', undef)
  $syslogsource = hiera_hash('sumo::syslogsource', undef)

  if $localfilesource {
    create_resources('sumo::localfilesource', $localfilesource)
  }

  if $remotefilesource {
    create_resources('sumo::remotefilesource', $remotefilesource)
  }

  if $syslogsource {
    create_resources('sumo::syslogsource', $syslogsource)
  }

}
