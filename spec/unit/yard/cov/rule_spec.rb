require 'spec_helper'

RSpec.describe YARD::Cov::Rule do
  describe '.coerce' do
    subject { described_class.coerce(document, config) }

    let(:document)    { DocumentMock.new                          }
    let(:config)      { double('config')                          }
    let(:rule_config) { YARD::Cov::RuleConfig.new(enabled: false) }

    before do
      allow(config)
        .to receive(:for_rule).with(described_class).and_return(rule_config)
    end

    it { should be_a(described_class) }

    it { should_not be_enabled }

    its(:document) { should be(document) }
  end

  describe '.describe' do
    subject { subclass.description }

    let(:subclass) do
      Class.new(described_class) { describe 'markup' }
    end

    after do
      YARD::Cov::Document.registered_rules.delete(subclass)
    end

    it { should be_a(YARD::Cov::RuleDescription) }
  end

  describe '.inherited' do
    let(:subclass) { Class.new(described_class) }

    after do
      YARD::Cov::Document.registered_rules.delete(subclass)
    end

    it 'registers rule' do
      expect(YARD::Cov::Document.registered_rules).to include(subclass)
    end
  end

  describe '#enabled?' do
    subject { described_class.new(document, config).enabled? }

    let(:document)     { double('document', path: 'Foo#bar') }
    let(:config)       { double('RuleConfig')                }
    let(:return_value) { double('Boolean')                   }

    before do
      allow(config).to receive(:enabled_for_path?).with('Foo#bar')
        .and_return(return_value)
    end

    it { should eq(return_value) }
  end

  describe '#initialize' do
    let(:document) { DocumentMock.new }

    context 'when rule config not given' do
      subject { described_class.new(document) }

      it { should be_a(described_class) }

      it { should be_enabled }
    end

    context 'when rule config is given' do
      subject { described_class.new(document, config) }

      let(:config) { YARD::Cov::RuleConfig.new(enabled: false) }

      it { should be_a(described_class) }

      it { should_not be_enabled }
    end
  end

  describe '#validatable?' do
    subject { described_class.new(document).validatable? }

    let(:document) { double('document') }

    it { should be(true) }
  end
end
