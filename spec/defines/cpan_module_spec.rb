require 'spec_helper'

describe 'perlbrew::cpan::module' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew::cpan::module class without any parameters on #{osfamily}" do
        let(:facts) {{
          :osfamily       => osfamily,
	  :concat_basedir => '/tmp'
        }}
        let(:title) { 'Class::DBI' }
	it { should contain_class('perlbrew::perl') }
	it { should contain_exec('install_Bundle::LWP') }
        it { should contain_exec('install_Crypt::SSLeay').that_requires('Exec[install_Bundle::LWP]') }
	it { should contain_exec('install_Class::DBI').that_requires('Exec[install_Crypt::SSLeay]') }
      end
    end
  end
end
