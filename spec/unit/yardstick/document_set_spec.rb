require 'spec_helper'

RSpec.describe Yardstick::DocumentSet do
  describe '#measure' do
    subject { described_class.new([document1, document2]).measure(config) }

    let(:document1) { double('document1') }
    let(:document2) { double('document2') }
    let(:config)    { double('config')    }

    let(:measurement1) { double('measurement') }
    let(:measurement2) { double('measurement') }

    before do
      expect(Yardstick::Document).to receive(:measure).with(document1, config)
        .and_return(Yardstick::MeasurementSet.new([measurement1]))

      expect(Yardstick::Document).to receive(:measure).with(document2, config)
        .and_return(Yardstick::MeasurementSet.new([measurement2]))
    end

    it { should be_a(Yardstick::MeasurementSet) }

    it { should include(measurement1, measurement2) }

    its(:length) { should be(2) }
  end
end
