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
