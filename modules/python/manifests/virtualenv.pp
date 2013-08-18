define python::virtualenv (
  $virtualenv = "/usr/local/bin/virtualenv",
  $packages = ["PIL"],
  $python_ldap = "https://jyuplone.cc.jyu.fi/packages/python-ldap-2.3.12.tar.gz"
){
  exec { "${virtualenv} ${name}":
    creates => $name,
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
    require => File["/usr/local/virtualenvs"]
  }

  exec { "${name}/bin/pip install -U distribute":
    onlyif => "test `${name}/bin/pip list | grep -c 'distribute (0.6.34)'` -eq 1",
    path => ["/bin", "/usr/bin", "/usr/local/bin"],
    require => [
      Exec["${virtualenv} ${name}"]
    ]
  }

  if "python-ldap" in $packages {
    exec { "${name}/bin/pip install ${python_ldap}":
      onlyif => "test `${name}/bin/pip list | grep -c python-ldap` -eq 0",
      path => ["/bin", "/usr/bin", "/usr/local/bin"],
      require => [
        Exec["${virtualenv} ${name}"],
        Package["openldap-devel"],
        Package["openldap-clients"]
      ]
    }
  }
  if "PIL" in $packages {
    exec { "${name}/bin/pip install PIL":
      onlyif => "test `${name}/bin/pip list | grep -c Pillow` -eq 0",
      path => ["/bin", "/usr/bin", "/usr/local/bin"],
      require => [
        Exec["${virtualenv} ${name}"],
      ]
    }
  }
}
