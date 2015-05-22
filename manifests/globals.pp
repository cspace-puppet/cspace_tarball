# Class: cspace_tarball::globals
#
# This module manages global configuration settings related to the server folder for a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

# TODO: This manifest separates out the declaration of global values
# used by the cspace_tarball manifest. For consistency, we might either
# consider adopting this 'globals' pattern across other modules
# (e.g. cspace_user), or alternately fold these declarations into
# the main 'init.pp' manifest, and then remove this separate manifest.

class cspace_tarball::globals (
  $release_version = hiera('collectionspace::release_version'),
  $server_dir_name = hiera('collectionspace::server_dir_name'),
  )

 {
    # TODO: Add validation check(s) for any provided values that override the defaults.
}
