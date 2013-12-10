# Class: cspace_tarball
#
# This module manages cspace_tarball
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class cspace_tarball {
  
  exec { 'wget cspace-server-4.0.tar.gz':
    command => 'wget ftp://source.collectionspace.org/pub/collectionspace/releases/4.0/cspace-server-4.0.tar.gz',
    cwd     => '/usr/local/share',
    creates => '/usr/local/share/cspace-server-4.0.tar.gz',
    path    => [ '/usr/bin', '/usr/sbin' ]
  }

  exec { 'extract cspace-server-4.0.tar.gz':
    command => 'tar -zxvof cspace-server-4.0.tar.gz',
    cwd     => '/usr/local/share',
    creates => '/usr/local/share/apache-tomcat-6.0.33',
    path    => [ '/bin', '/usr/bin', '/usr/sbin' ],
    require => Exec['wget cspace-server-4.0.tar.gz']
  }
  
  exec { 'chmod u+x *.sh':
    cwd     => '/usr/local/share/apache-tomcat-6.0.33/bin',  
    path    => [ '/bin', '/usr/bin', '/usr/sbin' ],  
    require => Exec['extract cspace-server-4.0.tar.gz'],
  }
}
