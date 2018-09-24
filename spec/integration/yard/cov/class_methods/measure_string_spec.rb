require 'spec_helper'

describe YARD::Cov, '.measure_string' do
  context 'with a string' do
    subject { described_class.measure_string("def foo;end\ndef bar;end") }

    it { should be_a(YARD::Cov::MeasurementSet) }

    it { should_not be_empty }
  end

  describe 'with no arguments' do
    it 'raises an exception' do
      expect { described_class.measure_string }
        .to raise_error(ArgumentError)
    end
  end
end
