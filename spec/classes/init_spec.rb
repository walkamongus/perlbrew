require 'spec_helper'
describe 'perlbrew' do

  context 'with defaults for all parameters' do
    it { should contain_class('perlbrew') }
  end
end
