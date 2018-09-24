require 'spec_helper'

describe YARD::Cov::Config, '#output=' do
  subject { config.output = output }

  let(:config) { described_class.new }
  let(:path)   { 'tmp/*.rb'          }

  before { config.output = path }

  context 'output' do
    subject { config.output }

    it { should be_a(YARD::Cov::ReportOutput) }

    its(:to_s) { should eql('tmp/*.rb') }
  end
end
