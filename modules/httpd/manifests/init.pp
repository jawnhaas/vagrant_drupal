
class httpd {

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  service { 'httpd':
    name      => 'httpd',
    require   => Package["httpd"],
    ensure    => running,
    enable    => true
  }

  file { "/etc/httpd/conf.d/vhost.conf":
    owner   => "root",
    group   => "root",
    mode    => 644,
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/vhost.conf",
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

}