# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/',
  notify  => Exec['nginx-restart'], # Trigger the Nginx restart after this command
}

# Restart Nginx
exec { 'nginx-restart':
  command     => '/etc/init.d/nginx restart', # Use full path to the init script
  path        => '/sbin:/bin:/usr/sbin:/usr/bin',
  refreshonly => true # Ensure this only runs when notified by 'fix--for-nginx'
}
