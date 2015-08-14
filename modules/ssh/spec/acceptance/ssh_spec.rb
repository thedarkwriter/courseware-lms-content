require 'puppetlabs_spec_helper/spec_helper_acceptance'

describe 'install and configure an ssh server and client' do
  describe 'install and configure the server' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'ssh':
          server => true,
          client => false,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)

      expect(shell("").exit_code).to be_zero
    end
  end
  describe 'install and configure the client' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
        class { 'ssh':
          server => false,
          client => true,
        }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)

      expect(shell("").exit_code).to be_zero
    end
  end
end
