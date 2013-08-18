class pyramid (
  $versions = ["pyramid"]
){
 	if "pyramid" in $versions {
    		python::virtualenv { "/usr/local/virtualenvs/pyramid":
			virtualenv => "/usr/local/bin/virtualenv-2.7",
			require => Class["python"]
    		}
	}
}
