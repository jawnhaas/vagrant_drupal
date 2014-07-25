### Info ###
This is a vagrant configuration to get a preexisting Drupal-based project up and running. All that is needed is a login for a Bitbucket or Github repo and a data import. 

### Requirements ###
* A full Drupal install in a repository
* SQL dump of that Drupal site

### Setup ###
1. Edit mainifests/init.pp with information about your repository and database import.

        # bitbucket login info
        $username = 'username'
        $password = 'password'

        # bitbucket repo link
        # ie. bitbucket.org/pennweb/pantheon_pennnews.git
        $repo = 'path/to/repo/repo.git'

        # sql import filename
        # ie. database.sql
        $sql_import = 'database.sql'

2. Place your SQL dump in data, make sure the file name matches whats in manifests/init.pp
3. Open a Terminal and change your working directory to the root of this project and run vagrant

        cd /path/to/vagrant
        vagrant up

4. Open up http://localhost:8080 in a browser.


##### To Get Images working #####
Add the following to your .htaccess file replacing www.mysite.com with your production or staging site's domain.

        #Start
        RewriteEngine on
        # Force image styles that have local files that exist to be generated.
        RewriteCond %{REQUEST_URI} ^/sites/([^\/]*)/files/styles/[^\/]*/public/((.*))$
        RewriteCond %{DOCUMENT_ROOT}/sites/%1/files/%2 -f
        RewriteRule ^(.*)$ $1 [QSA,L]
        # Otherwise, send anything else that's in the files directory to the
        # production server.
        RewriteCond %{REQUEST_URI} ^/sites/[^\/]*/files/.*$
        RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/css/.*$
        RewriteCond %{REQUEST_URI} !^/sites/[^\/]*/files/js/.*$
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule ^(.*)$ http://www.mysite.com/$1 [QSA,L]
        #End

##### Connecting your Host to Vagrant's Instance of MySQL ####
You can tunnel into MySQL by using the Standard TCP/IP over SSH connection method.

Setting | Value
-----|-----
SSH Hostname | 127.0.0.0:2222
SSH Username | vagrant
SSH Password | vagrant
MySQL Hostname | 127.0.0.0
MySQL Server Port | 3306
MySQL Username | root
MySQL Database | drupal_dev