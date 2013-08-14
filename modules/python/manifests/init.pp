class python{
  exec { "pip":
    command => "easy_install pip",
    creates => "/usr/local/pip",
    path => ["/usr/bin"],
    require => Class["essential"]
  }

file {"/usr/local/virtualenvs":
    ensure => "directory"
  }
  exec { "virtualenv":
    command => "pip install virtualenv",
    onlyif => "test `pip list | grep -c virtualenv` -eq 0",
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
    require => Exec["pip"],
  }
}
