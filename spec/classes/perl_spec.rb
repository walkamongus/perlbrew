require 'spec_helper'

describe 'perlbrew::perl' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew::perl class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily       => osfamily,
          :concat_basedir => '/tmp',
        }}
  
        it { should compile.with_all_deps }
        it do
          should contain_exec('install_perl_5.16.3').that_requires('Class[perlbrew::install]').that_requires('Class[perlbrew::config]').with({
            :command => 'source /opt/perl5/etc/bashrc; /opt/perl5/bin/perlbrew install perl-5.16.3 '
          })
        end
        it do
          should contain_exec('switch_to_perl_5.16.3').that_requires('Exec[install_perl_5.16.3]').with({
            :command => 'source /etc/profile; /opt/perl5/bin/perlbrew switch perl-5.16.3'
          })
        end

        context 'with defaults for all parameters' do
        end
  
      end
    end
  end
  
  context 'unsupported operating system' do
    describe 'perlbrew::perl class without any parameters on Solaris/Nexenta' do
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
