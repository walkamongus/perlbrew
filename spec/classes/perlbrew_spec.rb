require 'spec_helper'

describe 'perlbrew' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew class without any parameters on #{osfamily}" do
        let(:facts) {{
          :osfamily       => osfamily,
          :concat_basedir => '/tmp',
        }}
  
        it { should compile.with_all_deps }
  
        context 'with defaults for all parameters' do
          describe 'perlbrew::init' do
            it { should contain_class('perlbrew::params') }
            it { should contain_class('perlbrew::install') }
            it { should contain_class('perlbrew::config').that_requires('Class[perlbrew::install]') }
          end
          describe 'perlbrew::install' do
            it { should contain_package('curl') }
            it { should contain_file('/opt/perl5').with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            }) }
            it { should contain_exec('install_perlbrew').that_requires('Package[curl]') }
          end
          describe 'perlbrew::config' do
            it { should contain_concat('/etc/profile.d/perlbrew.sh') }
            it { should contain_class('concat::setup') }
            it { should contain_concat__fragment('export_perlbrew_root').with({
              :target   => '/etc/profile.d/perlbrew.sh',
              :content  => 'export PERLBREW_ROOT="/opt/perl5"',
              :order    => '01'
            }) }
          end
        end
      end
    end
  end
  
  context 'unsupported operating system' do
    describe 'perlbrew class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}
      let(:title) { 'my_perl_install' }
  
      it 'should fail' do
        expect { should compile }.to raise_error(/Nexenta not supported/)
      end
    end
  end
end
