require 'spec_helper'
describe 'perlbrew' do
  let(:facts) {{
    :osfamily       => 'RedHat',
    :concat_basedir => '/tmp',
  }}

  context 'with defaults for all parameters' do
    it { should contain_file('/opt/perl5') }
    it { should contain_exec('install_perlbrew').that_requires('Package[curl]') }
  end
end
