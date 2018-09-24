require 'spec_helper'

describe YARD::Cov::Document, '#line' do
  subject { described_class.new(docstring).line }

  let(:docstring) { double('docstring', object: object) }
  let(:object)    { double('object', line: 3)           }

  it { should be(3) }
end
