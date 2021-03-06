require 'spec_helper'

RSpec.describe YARD::Cov::DocumentSet do
  describe '#measure' do
    subject { described_class.new([document1, document2]).measure(config) }

    let(:document1) { double('document1') }
    let(:document2) { double('document2') }
    let(:config)    { double('config')    }

    let(:measurement1) { double('measurement') }
    let(:measurement2) { double('measurement') }

    before do
      expect(YARD::Cov::Document).to receive(:measure).with(document1, config)
        .and_return(YARD::Cov::MeasurementSet.new([measurement1]))

      expect(YARD::Cov::Document).to receive(:measure).with(document2, config)
        .and_return(YARD::Cov::MeasurementSet.new([measurement2]))
    end

    it { should be_a(YARD::Cov::MeasurementSet) }

    it { should include(measurement1, measurement2) }

    its(:length) { should be(2) }
  end
end
