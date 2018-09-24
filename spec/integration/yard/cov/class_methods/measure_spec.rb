require 'spec_helper'

describe YARD::Cov, '.measure' do
  describe 'with no arguments' do
    before :all do
      @measurements = described_class.measure
    end

    it_should_behave_like 'measured itself'
  end

  describe 'with a config' do
    before :all do
      config = YARD::Cov::Config.new(path: YARD::Cov::ROOT.join('lib', 'yard', 'cov.rb'))
      @measurements = described_class.measure(config)
    end

    it_should_behave_like 'measured itself'
  end
end
