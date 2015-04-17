class oracleclient::prepare {

  $required_packages  = $oracleclient::required_packages
  $oracle_user        = $oracleclient::oracle_user
  $oracle_group       = $oracleclient::oracle_group
  $oracle_home        = $oracleclient::oracle_home
  $inventory_location = $oracleclient::inventory_location
  $manage_users       = $oracleclient::manage_users

  package { $required_packages:
    ensure => installed,
  }

  file { $oracle_home:
    ensure => directory,
    owner  => $oracle_user,
    group  => $oracle_group,
    mode   => '0775',
  }

  file { $inventory_location:
    ensure  => directory,
    recurse => true,
    owner   => $oracle_user,
    group   => $oracle_group,
    mode    => '0775',
    backup  => false,
  }

  file { '/etc/oraInst.loc':
    ensure  => file,
    content => "inventory_loc=${inventory_location}\ninst_group=${oracle_group}",
  }

  if $manage_users == true {
    $needed_groups = [$oracle_group, 'dba']
    
    group { $needed_groups:
      ensure => present,
    }

    user { $oracle_user:
      ensure     => present,
      gid        => $oracle_group,
      comment    => 'Oracle',
      groups     => $needed_groups,
      home       => $oracle_home,
      managehome => false,

    }
  }

}
