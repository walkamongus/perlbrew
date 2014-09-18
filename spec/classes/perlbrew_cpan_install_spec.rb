require 'spec_helper'

describe 'perlbrew::cpan::install' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew::cpan::install class without any parameters on #{osfamily}" do
        let(:facts) {{
          :osfamily       => osfamily,
	  :concat_basedir => '/tmp'
        }}

        default_perl          = '5.16.3'
        default_perlbrew_root = '/opt/perl5'

	it { should compile.with_all_deps }
	it { should contain_class('perlbrew::perl') }
	it { should contain_exec('install_perl_modules').with({
	  :command     => "#{default_perlbrew_root}/perls/perl-#{default_perl}/bin/cpanm --installdeps --cpanfile cpanfile /tmp",
	  :refreshonly => 'true'
	}) }
      end
    end
  end
end
