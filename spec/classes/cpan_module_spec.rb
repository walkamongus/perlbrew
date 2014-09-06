require 'spec_helper'

describe 'perlbrew::cpan::module' do
  context 'supported operating systems' do
    ['RedHat',].each do |osfamily|
      describe "perlbrew::cpan::module class without any parameters on #{osfamily}" do
        let(:facts) {{
          :osfamily       => osfamily,
          :concat_basedir => '/tmp',
        }}
        let(:title) { 'Class::DBI' }
  
        context 'with defaults for all parameters' do
        end
  
      end
    end
  end
end
