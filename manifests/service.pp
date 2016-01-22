class sumo::service {
	include sumo
	service { $::sumo::params::sumo_service_name:
		ensure		=> running,
		hasstatus	=> true,
		hasrestart	=> true,
		enable		=> true,
		require		=> Class["sumo::config"],
	}
}
