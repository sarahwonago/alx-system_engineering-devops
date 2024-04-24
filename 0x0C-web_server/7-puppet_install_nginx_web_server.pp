# Update package repositories
exec { 'apt-get-update':
  command => '/usr/bin/apt-get update',
}

# Install Nginx package
package { 'nginx':
  ensure  => installed,
  require => Exec['apt-get-update'],
}

# Create index.html file
file { '/var/www/html/index.html':
  content => 'Hello World!',
  require => Package['nginx'],
}

# Configure redirection for /redirect_me
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  mode    => '0644',
  content => template('nginx/default.conf.erb'), # Use a template file for better maintainability
  require => Package['nginx'],
  notify  => Service['nginx'], # Reload Nginx after configuration changes
}

# Ensure Nginx service is running
service { 'nginx':
  ensure  => running,
  require => Package['nginx'],
}
