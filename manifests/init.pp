# Class: cspace_tarball
#
# This module manages the server folder for a CollectionSpace server instance.
# This folder is currently distributed as a 'tarball' ('.tar.gz' compressed archive file).
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

include cspace_environment::execpaths
include cspace_environment::osfamily
include cspace_environment::user

class cspace_tarball ( $release_version = '4.0', $user_acct = $cspace_environment::user::user_acct_name ) {
    
  # ---------------------------------------------------------
  # Identify executables paths for the active 
  # operating system family
  # ---------------------------------------------------------
  
  $os_family        = $cspace_environment::osfamily::os_family
  $linux_exec_paths = $cspace_environment::execpaths::linux_default_exec_paths
  $osx_exec_paths   = $cspace_environment::execpaths::osx_default_exec_paths
  
  case $os_family {
    RedHat, Debian: {
      $exec_paths = $linux_exec_paths
    }
    # OS X
    darwin: {
      $exec_paths = $osx_exec_paths
    }
    # Microsoft Windows
    windows: {
    }
    default: {
    }
  }
    
  # ---------------------------------------------------------
  # Download and 'explode' the distribution tarball
  # to create a CollectionSpace server folder
  # ---------------------------------------------------------

  case $os_family {
  
    RedHat, Debian, darwin: {
      
      $distribution_filename  = "cspace-server-${release_version}.tar.gz"
      $release_repository_dir = 'ftp://source.collectionspace.org/pub/collectionspace/releases'
      $server_parent_dir      = '/usr/local/share'
      $server_dir             = 'apache-tomcat-6.0.33'
    
      exec { 'Download CollectionSpace server distribution':
        command => "wget ${release_repository_dir}/${release_version}/${distribution_filename}",
        cwd     => $server_parent_dir,
        creates => "${server_parent_dir}/${distribution_filename}",
        path    => $exec_paths,
      }

      # FIXME: Verify whether the server directory already exists in
      # the target location before extracting the distribution into
      # that location.
      
      exec { 'Extract CollectionSpace server distribution':
        command => "tar -zxvof ${distribution_filename}",
        cwd     => $server_parent_dir,
        creates => "${server_parent_dir}/${server_dir}",
        path    => $exec_paths,
        require => Exec[ 'Download CollectionSpace server distribution' ]
      }
 
      # The two exec resources below can be processed in any order;
      # hence their sharing of a common 'require' attribute.
      
      exec { 'Remove tarball':
        command => "rm ${distribution_filename}",
        cwd     => $server_parent_dir,
        path    => $exec_paths,
        require => Exec[ 'Extract CollectionSpace server distribution' ]
      }
        
      exec { 'Make Tomcat shell scripts executable':
        command => 'chmod u+x *.sh',
        cwd     => "${server_parent_dir}/${server_dir}/bin",  
        path    => $exec_paths,
        require => Exec[ 'Extract CollectionSpace server distribution' ],
      }
        
      exec { 'Change ownership of server folder to CollectionSpace admin user':
        # Leaves existing group ownership of that folder 'as is'
        command => "chown -R ${user_acct}: ${server_parent_dir}/${server_dir}",
        path    => $exec_paths,
        require => Exec[ 'Make Tomcat shell scripts executable' ],
      }
      
    }
    
    # Microsoft Windows
    windows: {
    }
  
    default: {
    }
    
  } # end case
  
}
