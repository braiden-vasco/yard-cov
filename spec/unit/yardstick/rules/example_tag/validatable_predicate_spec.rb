require 'spec_helper'

describe Yardstick::Rules::ExampleTag, '#validatable?' do
  subject { described_class.new(document).validatable? }

  let(:document) { double('document') }

  before do
    allow(document).to receive(:api?).with(['private']) { false }
    allow(document).to receive(:tag_types).with('return') { %w[Object] }
  end

  it { should be(true) }

  context 'with private api' do
    before do
      allow(document).to receive(:api?).with(['private']).and_return(true)
    end

    it { should be(false) }
  end

  context 'with undefined return' do
    before do
      allow(document).to receive(:tag_types).with('return').and_return(['undefined'])
    end

    it { should be(false) }
  end
end
