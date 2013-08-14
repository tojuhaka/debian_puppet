class uwsgi{
  exec { "/usr/bin/pip install uwsgi":
    path => ["/bin", "/usr/bin"],
    require => Class["python"]
  }
}
