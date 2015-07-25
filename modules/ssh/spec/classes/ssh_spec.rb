require 'spec_helper'

describe 'ssh', :type => :class do
  ['RedHat', 'Debian'].each do |osfamily|
    let(:node) { 'testhost.example.com' }

    describe "when called with no parameters on #{osfamily}" do
      let (:facts) {{
        :osfamily  => "#{osfamily}",
        :ipaddress => '127.0.0.1'
      }}
      it {
        should contain_package('openssh-server').with({
        'ensure' => 'installed',
        })
        should contain_file('/etc/ssh/sshd_config').with({
          'ensure' => 'file',
          'mode'   => '0600',
          'source' => "puppet:///modules/ssh/server",
        })
        should contain_file('/etc/ssh/ssh_config').with({
          'ensure' => 'file',
          'mode'   => '0644',
          'source' => "puppet:///modules/ssh/client",
        })
        should contain_service('sshd').with({
          'ensure' => 'running',
          'enable' => 'true',
        })
      }
    end
  end
end
