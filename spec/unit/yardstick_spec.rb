require 'spec_helper'

RSpec.describe Yardstick do
  describe '.measure' do
    context 'when no arguments' do
      subject { described_class.measure }

      it 'delegates to Processor' do
        processor = double('processor')
        config = instance_of(Yardstick::Config)

        allow(Yardstick::Processor)
          .to receive(:new).with(config).and_return(processor)
        expect(processor).to receive(:process)
        subject
      end
    end

    context 'when custom config' do
      subject { described_class.measure(config) }

      let(:config) { double('config') }

      it 'delegates to Processor' do
        processor = double('processor')
        allow(Yardstick::Processor)
          .to receive(:new).with(config).and_return(processor)
        expect(processor).to receive(:process)
        subject
      end
    end
  end

  describe '.measure_string' do
    let(:string) { double('string') }

    context 'when no arguments' do
      subject { described_class.measure_string(string) }

      it 'delegates to Processor' do
        processor = double('processor')
        config = instance_of(Yardstick::Config)
        allow(Yardstick::Processor)
          .to receive(:new).with(config).and_return(processor)
        expect(processor).to receive(:process_string).with(string)
        subject
      end
    end

    context 'when custom config' do
      subject { described_class.measure_string(string, config) }

      let(:config) { double('config') }

      it 'delegates to Processor' do
        processor = double('processor')
        allow(Yardstick::Processor)
          .to receive(:new).with(config).and_return(processor)
        expect(processor).to receive(:process_string).with(string)
        subject
      end
    end
  end
end
