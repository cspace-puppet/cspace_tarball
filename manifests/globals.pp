# Class: cspace_tarball::config
#
# This module manages configuration settings related to the server folder for a CollectionSpace server instance.
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#

# TODO: This manifest is a near-term expedient for storing - and facilitating per-run
# changes to - global values used by the cspace_tarball manifest. We can and should
# consider alternatives for providing the values contained in this manifest.

class cspace_tarball::globals ( $release_version = '4.0' ) {
    # TODO: Add validation check(s) for any provided values that override the defaults.
}
