require 'spec_helper'
describe 'perlbrew' do
  let(:facts) {{
    :osfamily       => 'RedHat',
    :concat_basedir => '/tmp',
  }}

  context 'with defaults for all parameters' do
    it { should contain_concat('/etc/profile.d/perlbrew.sh') }
  end
end
