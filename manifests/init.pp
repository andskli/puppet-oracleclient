# == Class: oracleclient
#
# Module intends to setup and manage Oracle client
#
# === Parameters
#
# Document parameters here.
#
# [*installer_source*]
#   Path to unzipped Oracle client install dir. This dir should include the 
#   file called runInstaller.
#
# [*install_type*]
#   Install type to be specified in the response file.
#
# [*install_components*]
#   Array of Oracle components to be specified in the response file. See
#   oracleclient::params for default values.
#
# [*installer_debug*]
#   Toggle debug mode for runInstaller. true or false.
#
# [*oracle_hostname*]
#   Hostname to be specified in the response file
#
# [*manage_users*]
#   Should we setup oracle users for you? true or false.
#   TODO: Fix UID/GID option
#
# [*oracle_base*]
#   Oracle base dir, also sets home directory for user to this path 
#   (default: /opt/oracle)
#
# [*oracle_home*]
#   Oracle home dir. This is *REQUIRED*, should probably be set to first three
#   octets of semantic version of oracle client, i.e. '12.1.0' (default: undef)
#
# [*oracle_user*]
#   Oracle user name (default: oracle)
# [*oracle_group*]
#   Oracle group name (default: oinstall)
#
# [*inventory_location*]
#   Path to oraInventory (default: /opt/oraInventory)
#
# [*selected_languages*]
#   Which languages to tell responsefile to install during setup.
#
# [*required_packages*]
#   A set of packages required to install oracle client.
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'oracleclient':
#    installer_source => '/path/to/nfs/oracle/client',
#    manage_users     => false,
#    install_type     => 'Custom',
#    oracle_base      => '/opt/oracle',
#    oracle_home      => '/opt/oracle/12.1.0',
#  }
#
# === Authors
#
# Andreas Lindh <andreas@superblock.se>
#
# === Copyright
#
# Copyright 2015 Andreas Lindh, unless otherwise noted.
#
class oracleclient(
  $installer_source           = $oracleclient::params::installer_source,
  $install_type               = $oracleclient::params::install_type,
  $install_components         = $oracleclient::params::install_components,
  $installer_debug            = $oracleclient::params::installer_debug,
  $oracle_hostname            = $oracleclient::params::oracle_hostname,
  $manage_users               = $oracleclient::params::manage_users,
  $oracle_home                = $oracleclient::params::oracle_home,
  $oracle_user                = $oracleclient::params::oracle_user,
  $oracle_base                = $oracleclient::params::oracle_base,
  $oracle_group               = $oracleclient::params::oracle_group,
  $inventory_location         = $oracleclient::params::inventory_location,
  $selected_languages         = $oracleclient::params::selected_languages,
  $required_packages          = $oracleclient::params::required_packages
) inherits oracleclient::params {

  stage { 'prepare':
    before => Stage['main'],
  }

  stage { 'post':
  }

  Stage['main'] -> Stage['post']

  class { 'oracleclient::prepare':
    stage => prepare,
  }

  class { 'oracleclient::install':
    stage => main,
  }

  class { 'oracleclient::post':
    stage => post,
  }

}
