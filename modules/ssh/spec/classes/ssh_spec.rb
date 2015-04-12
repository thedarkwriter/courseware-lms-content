require 'spec_helper'
describe 'ssh', :type => :class do
  let(:node) { 'testhost.example.com' }

  describe 'when called with no parameters on RedHat' do
    let (:facts) {
      {
        :osfamily  => 'Redhat',
        :ipaddress => '127.0.0.1'
      }
    }
    it {
      should contain_package('openssh-server').with({
        'ensure' => 'installed',
      })
      should contain_file('/etc/ssh/sshd_config').with({
        'ensure' => 'file',
        'mode'   => '0600',
        'source' => "puppet:///modules/ssh/#{facts[:osfamily]}-server",
      })
      should contain_file('/etc/ssh/ssh_config').with({
        'ensure' => 'file',
        'mode'   => '0644',
        'source' => "puppet:///modules/ssh/#{facts[:osfamily]}-client",
      })
      should contain_service('sshd').with({
        'ensure' => 'running',
        'enable' => 'true',
      })
    }
  end

  describe 'when called with no parameters on Debian' do
    let (:facts) {
      {
        :osfamily  => 'Debian',
        :ipaddress => '127.0.0.1'
      }
    }
    it {
      should contain_package('openssh-server').with({
        'ensure' => 'installed',
      })
      should contain_file('/etc/ssh/sshd_config').with({
        'ensure' => 'file',
        'mode'   => '0600',
        'source' => "puppet:///modules/ssh/#{facts[:osfamily]}-server",
      })
      should contain_file('/etc/ssh/ssh_config').with({
        'ensure' => 'file',
        'mode'   => '0644',
        'source' => "puppet:///modules/ssh/#{facts[:osfamily]}-client",
      })
      should contain_service('sshd').with({
        'ensure' => 'running',
        'enable' => 'true',
      })
    }
  end
end
