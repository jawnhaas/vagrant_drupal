class dev_install {
	include install-site
}


class install-site {

	vcsrepo { 'cfs':
	            ensure => present,
	            path => "/webroot/public_html",
	            provider => git,
	            require => Class['git'],
	            source => "https://${username}:${password}@${repo}",
    }
    ->
	file { "/webroot/public_html/sites/default/":
	    ensure => "directory",
	    mode   => 777,
	}
	->
	file { "/webroot/public_html/sites/default/files":
	    ensure => "directory",
	    mode   => 777,
	}
	->
	file { "/webroot/public_html/sites/default/settings.php":
	    owner   => "root",
	    group   => "root",
	    mode    => 644,
	    replace => true,
	    ensure  => present,
	    source  => "/vagrant/files/site-settings.php",
		}
}
