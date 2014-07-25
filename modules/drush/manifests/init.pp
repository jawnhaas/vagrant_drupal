class drush {
  exec {
    "/usr/bin/pear channel-discover pear.drush.org":
    alias   => "discover-drush",
    require => Package["php-pear"],
  }

  exec {
    "/usr/bin/pear install drush/drush":
    alias   => "install-drush",
    require => Exec["discover-drush"],
  }

  exec { "sudocmd":
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    command => "drush",
    user => root,
    alias   => "firstrun-drush",
    require => Exec["install-drush"],
  }
}