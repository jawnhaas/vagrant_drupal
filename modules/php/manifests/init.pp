class php {
  package { [ "php", "php-mysql", "php-gd", "php-mbstring" ]:
    ensure => installed,
  }
} 