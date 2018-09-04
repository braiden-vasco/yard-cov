require 'spec_helper'

RSpec.describe Yardstick::Processor do
  describe '#process' do
    subject { described_class.new(config).process }

    let(:config)    { double('config', path: path) }
    let(:path)      { Pathname('foo/bar.rb')       }
    let(:documents) { double('document set')       }

    it 'measures files specified in the config' do
      expect(Yardstick::Parser)
        .to receive(:parse_paths).with(['foo/bar.rb']).and_return(documents)
      expect(documents).to receive(:measure).with(config)
      subject
    end
  end

  describe '#process_string' do
    subject { described_class.new(config).process_string(string) }

    let(:config)    { double('config')       }
    let(:string)    { double('string')       }
    let(:documents) { double('document set') }

    it 'measures specified string' do
      expect(Yardstick::Parser)
        .to receive(:parse_string).with(string).and_return(documents)
      expect(documents).to receive(:measure).with(config)
      subject
    end
  end
end
