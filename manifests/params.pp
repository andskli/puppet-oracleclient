class oracleclient::params {

  $installer_source         = undef
  $install_type             = 'InstantClient'
  $install_components       = [
                                'oracle.sqlj:12.1.0.2.0',
                                'oracle.rdbms.util:12.1.0.2.0',
                                'oracle.javavm.client:12.1.0.2.0',
                                'oracle.sqlplus:12.1.0.2.0',
                                'oracle.dbjava.jdbc:12.1.0.2.0',
                                'oracle.ldap.client:12.1.0.2.0',
                                'oracle.rdbms.oci:12.1.0.2.0',
                                'oracle.precomp:12.1.0.2.0',
                                'oracle.xdk:12.1.0.2.0',
                                'oracle.network.aso:12.1.0.2.0',
                                'oracle.oraolap.mgmt:12.1.0.2.0',
                                'oracle.network.client:12.1.0.2.0',
                                'oracle.network.cman:12.1.0.2.0',
                                'oracle.network.listener:12.1.0.2.0',
                                'oracle.ordim.client:12.1.0.2.0',
                                'oracle.odbc:12.1.0.2.0',
                                'oracle.has.client:12.1.0.2.0',
                                'oracle.dbdev:12.1.0.2.0',
                                'oracle.rdbms.scheduler:12.1.0.2.0',
                              ]
  $installer_debug          = false
  $oracle_hostname          = undef
  $manage_users             = true
  $manage_tnsnames          = false
  $oracle_base              = '/opt/oracle'
  $oracle_home              = '/opt/oracle/home'
  $oracle_user              = 'oracle'
  $oracle_group             = 'oinstall'
  $inventory_location       = '/opt/oraInventory'
  $selected_languages       = ['en']
  $tnsnames                 = undef

  $required_packages        = ['binutils', 'compat-libcap1', 'gcc', 'gcc-c++',
      'glibc.i686', 'glibc', 'glibc-devel.i686', 'glibc-devel', 'ksh',
      'libaio.i686', 'libaio', 'libaio-devel.i686', 'libaio-devel', 'libgcc',
      'libgcc.i686', 'libstdc++', 'libstdc++.i686', 'libstdc++-devel.i686',
      'libstdc++-devel', 'libXi.i686', 'libXi', 'libXtst.i686', 'libXtst',
      'make', 'sysstat', 'perl-TermReadKey']

}
