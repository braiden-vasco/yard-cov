require 'spec_helper'

describe YARD::Cov::Config, '#output' do
  subject { described_class.new(options).output }

  context 'when default options' do
    let(:options) { {} }

    it { should be_instance_of(YARD::Cov::ReportOutput) }

    its(:to_s) { should eql('measurements/report.txt') }
  end
end
