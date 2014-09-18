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

        default_perl          = '5.16.3'
        default_perlbrew_root = '/opt/perl5'

	it { should compile.with_all_deps }
	it { should contain_class('perlbrew::perl') }
	it { should contain_concat__fragment('perl_module_Class::DBI') }
      end
    end
  end
end
