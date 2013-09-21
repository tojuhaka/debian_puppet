class firewall_settings {

	firewall { '100 allow http and https access':
	    port   => [80, 443],
	    proto  => tcp,
	    action => accept,
	    require => Class['firewall']
	}
}
