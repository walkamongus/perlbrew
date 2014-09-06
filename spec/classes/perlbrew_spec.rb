require 'spec_helper'

describe 'perlbrew' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily       => osfamily,
          :concat_basedir => '/tmp',
        }}
  
        it { should compile.with_all_deps }
  
        context 'with defaults for all parameters' do
          it { should contain_class('perlbrew::install') }
          it { should contain_class('perlbrew::config').that_requires('Class[perlbrew::install]') }
          it do
            should contain_file('/opt/perl5').with({
              'ensure' => 'directory',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0755',
            })
          end
          it { should contain_exec('install_perlbrew').that_requires('Package[curl]') }
          it { should contain_concat('/etc/profile.d/perlbrew.sh') }
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
  
      it 'should fail' do
        expect { should compile }.to raise_error(/Nexenta not supported/)
      end
    end
  end
end
