require 'spec_helper'

RSpec.describe Yardstick::OrderedSet do
  describe '#each' do
    subject { set.each { |*args| yielded << args } }

    let(:set)     { described_class.new([item]) }
    let(:item)    { double('item')              }
    let(:yielded) { []                          }

    it { should be(set) }

    it 'yields items' do
      subject
      expect(yielded).to eql([[item]])
    end
  end

  describe '#empty?' do
    subject { set.empty? }

    context 'when there are no items' do
      let(:set) { described_class.new }

      it { should be(true) }
    end

    context 'when there are items' do
      let(:set) { described_class.new([double('item')]) }

      it { should be(false) }
    end
  end

  describe '#include?' do
    subject { set.include?(item) }

    let(:item) { double('item') }

    context 'when provided an included item' do
      let(:set) { described_class.new([item]) }

      it { should be(true) }
    end

    context 'when provided an excluded item' do
      let(:set) { described_class.new }

      it { should be(false) }
    end
  end

  describe '#index' do
    subject { set.index(item) }

    let(:item) { double('item') }

    context 'when provided an included item' do
      let(:set) { described_class.new([item]) }

      it { should be(0) }
    end

    context 'when provided an excluded item' do
      let(:set) { described_class.new }

      it { should be_nil }
    end
  end

  describe '#<<' do
    subject { set << item }

    let(:set)  { described_class.new }
    let(:item) { double('item')      }

    it { should be(set) }

    it { should include(item) }

    its(:length) { should be(1) }

    context 'when operation is repeated' do
      it do
        expect { set << item << item }.to change(set, :to_a).from([]).to([item])
      end
    end
  end

  describe '#length' do
    subject { described_class.new(items).length }

    let(:items) { [double('item'), double('item')] }

    it { should be(2) }
  end

  describe '#merge' do
    subject { set.merge(other) }

    let(:set)   { described_class.new([item1]) }
    let(:other) { described_class.new([item2]) }
    let(:item1) { double('item')               }
    let(:item2) { double('item')               }

    it { should be(set) }

    it { should include(item1, item2) }
  end
end
