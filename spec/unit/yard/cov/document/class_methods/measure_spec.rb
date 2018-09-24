require 'spec_helper'

describe YARD::Cov::Document, '.measure' do
  subject { described_class.measure(document, config) }

  let(:config)    { YARD::Cov::Config.new }
  let(:document)  { double('document')    }

  let(:registered_rules) do
    described_class.instance_variable_get(:@registered_rules)
  end

  before do
    registered_rules.each do |rule_class|
      expect(rule_class).to receive(:coerce).with(document, config)
        .and_return(ValidRule.new(document))
    end
  end

  it { should be_a(YARD::Cov::MeasurementSet) }

  its(:first) { should be_a(YARD::Cov::Measurement) }
end
