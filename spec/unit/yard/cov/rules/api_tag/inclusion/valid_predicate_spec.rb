require 'spec_helper'

describe YARD::Cov::Rules::ApiTag::Inclusion, '#valid?' do
  subject { described_class.new(document).valid? }

  let(:document) { double('document') }

  %w[public semipublic private].each do |method_visibility|
    context "with #{method_visibility} method" do
      before do
        allow(document).to receive(:tag_text).with('api').and_return(method_visibility)
      end

      it { should be(true) }
    end
  end

  context 'with unknown method visibility' do
    before do
      allow(document).to receive(:tag_text).with('api').and_return('unknown')
    end

    it { should be(false) }
  end
end
