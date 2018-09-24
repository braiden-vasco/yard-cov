require 'spec_helper'

describe YARD::Cov::Document::NullTag, '#text' do
  subject { described_class.new.text }

  it { should be_nil }
end
