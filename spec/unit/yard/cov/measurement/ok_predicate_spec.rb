require 'spec_helper'

describe YARD::Cov::Measurement, '#ok?' do
  subject { described_class.new(rule).ok? }

  let(:document) { DocumentMock.new }

  context 'when rule is valid' do
    let(:rule) { ValidRule.new(document) }

    it { should be(true) }
  end

  context 'when rule is not valid' do
    let(:rule) { InvalidRule.new(document) }

    it { should be(false) }
  end

  context 'when rule is disabled' do
    let(:rule) { DisabledRule.new(document) }

    it { should be(true) }
  end
end
