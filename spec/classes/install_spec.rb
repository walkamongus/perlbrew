require 'spec_helper'
describe 'perlbrew' do
  let(:facts) {{
    :osfamily => 'RedHat',
  }}

  context 'with defaults for all parameters' do
    it { should contain_file('/opt/perl5') }
    it { should contain_exec('install_perlbrew').that_requires('Package[curl]') }
    it { should contain_exec('perlbrew_init').that_requires('Exec[install_perlbrew]') }
  end
end
