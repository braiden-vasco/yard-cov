require 'spec_helper'

require 'yard/cov/rake/verify'

describe Yardstick::Rake::Verify do
  before do
    described_class.new do |verify|
      verify.threshold = 100
      verify.path = 'lib/yard/cov.rb'
    end
  end

  it 'displays coverage summary when executed' do
    capture_stdout { Rake::Task['verify_measurements'].execute }

    expect(@output).to eql("YARD-Coverage: 100.0% (threshold: 100%)\n")
  end
end
