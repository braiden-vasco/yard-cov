require 'spec_helper'

describe Yardstick::Rules::ReturnTag, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  context 'when with protected api tag' do
    before { allow(document).to receive(:has_tag?).with('return').and_return(true) }

    it { should be(true) }
  end

  context 'when not protected visibility' do
    before { allow(document).to receive(:has_tag?).with('return').and_return(false) }

    it { should be(false) }
  end
end
