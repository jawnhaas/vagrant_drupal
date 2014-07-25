
class dev_import {
	include site_import
}

class site_import {
	include 'mysql::server'
	mysql::db { 'drupal_dev':
	  user     => 'root',
	  host     => '127.0.0.1',
	  password => ''
	}
	->
	exec { "import_site_dump":
        cwd => "/data",
        timeout => 3600, # Too long, but this can take awhile
        command => "mysql -u root drupal_dev < ${sql_import}";
    }
}
