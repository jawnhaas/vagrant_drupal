Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

# bitbucket login info
$username = ''
$password = ''

# bitbucket repo link
# ie. bitbucket.org/pennweb/pantheon_pennnews.git
$repo = ''

# sql import filename
$sql_import = ''

include iptables
include httpd
include php
include pear
include drush
include git
include stdlib
include dev_install
include dev_import
include restart_services


Class['iptables'] ->  Class['httpd'] -> Class['git'] -> Class['php'] -> Class['pear'] -> Class['drush'] -> Class['dev_install'] -> Class['dev_import'] -> Class['restart_services']

Exec {
    # This is what makes all commands spew verbose output
    logoutput => true
}


class restart_services {
	 exec { 'restart-httpd':
     command => 'service httpd restart'
  }
}

class iptables {

  package { "iptables":
    ensure => present;
  }

  service { "iptables":
    require => Package["iptables"],

    hasstatus => true,
    status => "true",

    # hasrestart => false,

  }

  file { "/etc/sysconfig/iptables":
    owner   => "root",
    group   => "root",
    mode    => 600,
    replace => true,
    ensure  => present,
    # source  => "puppet:///files/iptables.txt",
    source  => "/vagrant/files/iptables.txt",
    # content => template("puppet:///templates/iptables.txt"),
    require => Package["iptables"],

    notify  => Service["iptables"],
    ;
  }

}
