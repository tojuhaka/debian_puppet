class vim{
  exec { "/usr/local/bin/pip install uwsgi":
    path => ["/bin", "/usr/bin"],
    require => Class["python"]
  }
}
