require 'spec_helper'

describe YARD::Cov::Document, '#file' do
  subject { described_class.new(docstring).file }

  let(:docstring) { YARD::Registry.all(:method).first.docstring }
  let(:file)      { YARD::Cov::ROOT.join('lib', 'yard', 'cov.rb') }

  before { YARD.parse([file.to_s], [], YARD::Logger::ERROR) }

  it { should be_kind_of(Pathname) }

  it { should eql(file) }
end
