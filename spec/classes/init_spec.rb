require 'spec_helper'
describe 'sumo' do

  context 'with defaults for all parameters' do
    it { should contain_class('sumo') }
  end
end
