require 'spec_helper'

describe YARD::Cov::Document, '#path' do
  subject { described_class.new(docstring).path }

  let(:docstring) { double('docstring', object: object) }
  let(:object)    { double('object', path: 'Foo#bar')   }

  it { should eql('Foo#bar') }
end
