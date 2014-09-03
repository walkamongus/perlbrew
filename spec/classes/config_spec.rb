require 'spec_helper'
describe 'perlbrew' do
  let(:facts) {{
    :osfamily => 'RedHat',
  }}

  context 'with defaults for all parameters' do
    it { should contain_file('/etc/profile.d/perlbrew.sh') }
  end
end
