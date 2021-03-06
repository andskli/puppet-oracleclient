require 'spec_helper'
describe 'oracleclient' do

  context 'with defaults for all parameters' do
    it { should contain_class('oracleclient') }
    it 'should manage oraInventory' do
      should contain_file("/opt/oraInventory").with({
        :ensure  => 'directory',
        :path    => '/opt/oraInventory',
        :recurse => 'true',
        :owner   => 'oracle',
        :group   => 'oinstall',
      })
    end

    it 'should create & manage oracle user and gorup' do
      should contain_user("oracle").with({
        :name => 'oracle',
        :home => '/opt/oracle',
      })
      should contain_group("oinstall").with({
        :name => 'oinstall',
      })
      should contain_group("dba")
    end

    it 'should create response file with some content' do
      should contain_file("/opt/oracle/oracleclient_install.rsp").with_content(/oracle.install.client.installType=(.+)/)
      should contain_file("/opt/oracle/oracleclient_install.rsp").with_content(/INVENTORY_LOCATION=\/opt\/oraInventory/)
      should contain_file("/opt/oracle/oracleclient_install.rsp").with_content(/ORACLE_BASE=\/opt\/oracle/)
      should contain_file("/opt/oracle/oracleclient_install.rsp").with_content(/ORACLE_HOME=\/opt\/oracle\/home/)
    end

    it 'should create ORACLE_HOME directory' do
      should contain_file("/opt/oracle/home").with({
        :ensure => 'directory',
        :path   => '/opt/oracle/home',
        :owner  => 'oracle',
        :group  => 'oinstall',
      })
    end

    it 'should create ORACLE_BASE directory' do
      should contain_file("/opt/oracle").with({
        :ensure => 'directory',
        :path   => '/opt/oracle',
        :owner  => 'oracle',
        :group  => 'oinstall',
        :mode   => '0775',
      })
    end

    it 'should create ld.so.conf.d file' do
      should contain_file("/etc/ld.so.conf.d/oracle_client.conf").
        with_content(/\/opt\/oracle\/home/).
        with_mode('0644')
    end

  end

  context 'with install_type => Custom' do
    let(:params) { 
      {
        :install_type => 'Custom'
      }
    }
    
    it 'should exec root.sh' do
      should contain_exec("/opt/oracle/home/root.sh")
    end

  end

  context 'with manage_tnsnames => true' do
    let(:params) {
      {
        :manage_tnsnames => true,
        :tnsnames        => {
          'net_svc_nameETT' => {
            'address_list'   => [
              '(PROTOCOL = TCP)(HOST = DBSRV01)(PORT = 1521)',
              'addr2'
            ],
          },
          'net_svc_nameTVA' => {
            'address_list'     => [
              '(PROTOCOL = TCP)(HOST = DBSRV002)(PORT = 1521)',
            ],
          },
        },
      }
    }

    it 'should create tnsnames.ora' do
      should contain_file("/opt/oracle/home/network/admin/tnsnames.ora").with({
        :owner => "oracle",
        :group => "oinstall",
      })
    end
  end

end
