class oracleclient::install {

  $installer_source     = $oracleclient::installer_source
  $install_type         = $oracleclient::install_type
  $install_components   = $oracleclient::install_components
  $installer_debug      = $oracleclient::installer_debug
  $oracle_hostname      = $oracleclient::oracle_hostname
  $oracle_home          = $oracleclient::oracle_home
  $oracle_user          = $oracleclient::oracle_user
  $oracle_group         = $oracleclient::oracle_group
  $inventory_location   = $oracleclient::inventory_location
  $selected_languages   = $oracleclient::selected_languages
  
  if $installer_debug == true {
    $debug_real = '-debug'
  }

  $responsefile = "${oracle_home}/oracleclient_install.rsp"
  file { $responsefile:
    ensure  => file,
    content => template('oracleclient/responsefile_client.rsp.erb'),
  }

  exec { 'runInstaller':
    command     => "${installer_source}/runInstaller -noconfig ${debug_real} -force -waitforcompletion -ignoreSysPrereqs -ignorePrereq -silent -responseFile ${responsefile}",
    user        => $oracle_user,
    group       => $oracle_group,
    timeout     => 0,
    subscribe   => File[$responsefile],
    refreshonly => true,
  }

  file { '/etc/ld.so.conf.d/oracle_client.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => "${oracle_home}/lib\n${oracle_home}",
    require => Exec['runInstaller'],
  }
  
  exec { 'ldconfig':
    path      => '/usr/bin:/usr/sbin:/bin:/sbin',
    subscribe => File['/etc/ld.so.conf.d/oracle_client.conf'],
  }

}
