require 'spec_helper'

describe YARD::Cov::Document::NullTag, '#types' do
  subject { described_class.new.types }

  it { should eql([]) }
end
