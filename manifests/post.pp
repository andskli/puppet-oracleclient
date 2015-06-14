class oracleclient::post {
  $install_type    = $oracleclient::install_type
  $oracle_home     = $oracleclient::oracle_home
  $oracle_user     = $oracleclient::oracle_user
  $oracle_group    = $oracleclient::oracle_group
  $manage_tnsnames = $oracleclient::manage_tnsnames
  $tnsnames        = $oracleclient::tnsnames


  if $install_type == 'Custom' {

    exec { "${oracle_home}/root.sh":
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      user        => root,
      group       => root,
      refreshonly => true,
      onlyif      => "test -f ${oracle_home}/root.sh"
    }

  }

  if $manage_tnsnames {
    file { "${oracle_home}/network/admin/tnsnames.ora":
      ensure  => file,
      owner   => $oracle_user,
      group   => $oracle_group,
      mode    => '0644',
      content => template('oracleclient/tnsnames.ora.erb'),
    }
  }

}
