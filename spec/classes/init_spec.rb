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
      should contain_file("/opt/oracle/oracleclient_install.rsp").with_content(/ORACLE_HOME=\/opt\/oracle/)
    end

  end
end
