require 'spec_helper'

describe YARD::Cov, '.round_percentage' do
  subject { described_class.round_percentage(12.3456) }

  it { should eql(12.3) }
end
