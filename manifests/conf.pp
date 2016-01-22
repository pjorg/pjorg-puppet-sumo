#
#
#
define sumo::conf (
  $accessid = undef,
  $accesskey = undef,
  $clobber = undef,
  $email = undef,
  $ephemeral = undef,
  $name = undef,
  $override = undef,
  $password = undef,
  $proxyHost = undef,
  $proxyNtlmDomain = undef,
  $proxyPassword = undef,
  $proxyPort = undef,
  $proxyUser = undef,
  $sources = undef,
  $syncSources = undef,
) {
  include sumo
  include sumo::params
  
  if ($accessid != undef or $accesskey != undef) and ($email != undef or $password != undef) {
    fail('You must pass either an accessid/accesskey pair or an email/password pair, not both.')
  } elsif (($accessid == undef and $accesskey != undef) or ($accessid != undef and $accesskey == undef)) {
    fail('You must pass both the accessid and accesskey.')
  } elsif (($email == undef or $password != undef) or ($email != undef or $password == undef)) {
    fail('You must pass both the email and password.')
  }
  
  file { $::sumo::params::sumo_service_config:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    content => template("${module_name}/sumo.conf.erb"),
  }
}
