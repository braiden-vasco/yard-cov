require 'spec_helper'

describe YARD::Cov::Config, '#initialize' do
  it { should be_instance_of(described_class) }

  context 'when given custom options' do
    subject { described_class.new(verbose: false) }

    its(:verbose?) { should be(false) }
  end

  context 'when block provided' do
    subject do
      described_class.new { |config| config.path = new_path }
    end

    let(:new_path) { 'custom' }

    it { should be_instance_of(described_class) }

    it 'executes block as config' do
      expect(subject.path).to eql(new_path)
    end
  end
end
