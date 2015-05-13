class oracleclient::post {
  $install_type = $oracleclient::install_type
  $oracle_home  = $oracleclient::oracle_home
  
  if $install_type == 'Custom' {

    exec { "${oracle_home}/root.sh":
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
      user        => root,
      group       => root,
      refreshonly => true,
      onlyif      => "test -f ${oracle_home}/root.sh"
    }

  }

}
