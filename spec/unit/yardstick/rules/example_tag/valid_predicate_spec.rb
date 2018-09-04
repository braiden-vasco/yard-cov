require 'spec_helper'

describe Yardstick::Rules::ExampleTag, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  context 'with example tag' do
    before do
      allow(document).to receive(:has_tag?).with('example').and_return(true)
    end

    it { should be(true) }
  end

  context 'without example tag' do
    before do
      allow(document).to receive(:has_tag?).with('example').and_return(false)
    end

    it { should be(false) }
  end
end
