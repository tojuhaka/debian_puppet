class essential {

	firewall { '100 allow http and https access':
	    port   => [80, 443],
	    proto  => tcp,
	    action => accept,
	    require => Class['firewall']
	}

	exec { 'apt-get update':
	    command => "/usr/bin/apt-get update",
	    onlyif => "/bin/bash -c 'exit $(( $(( $(date +%s) - $(stat -c %Y /var/lib/apt/lists/$( ls /var/lib/apt/lists/ -tr1|tail -1 )) )) <= 604800 ))'"
	}

	package { ["vim", "build-essential", "python-setuptools", "git", "less", "python-dev", "curl"]:
		ensure => "installed",
		require => Exec["apt-get update"]
	}

	
	file { "/var/pyramid":
    		ensure => "directory",
		owner => "root",
		mode => 750
	}
}
