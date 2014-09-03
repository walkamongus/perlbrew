require 'spec_helper'

describe 'perlbrew' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "perlbrew class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('perlbrew::params') }
        it { should contain_class('perlbrew::install').that_comes_before('perlbrew::config') }
        it { should contain_class('perlbrew::config') }
        it { should contain_class('perlbrew::service').that_subscribes_to('perlbrew::config') }

        it { should contain_service('perlbrew') }
        it { should contain_package('perlbrew').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'perlbrew class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('perlbrew') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
