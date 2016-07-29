# sumo::yaml
#
# Allow defines to be called by an enc yaml file 
#
class sumo::yaml (
  $localfilesource = undef,
  $remotefilesource = undef,
  $syslogsource = undef,
) {

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
