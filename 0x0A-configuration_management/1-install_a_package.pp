# This Puppet manifest installs Flask using pip3 and ensures it's at version 2.1.0

# Define the package resource
package { 'Flask':
  ensure   => '2.1.0', 
  provider => 'pip3', 
}
