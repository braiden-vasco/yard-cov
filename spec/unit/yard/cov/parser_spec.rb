require 'spec_helper'

RSpec.describe YARD::Cov::Parser do
  describe '.parse_paths' do
    subject(:document_set) { described_class.parse_paths(paths) }

    let(:paths)         { double('paths')                                       }
    let(:method_object) { double(file: 'foo.rb', line: 4, docstring: docstring) }
    let(:docstring)     { double('docstring')                                   }

    before do
      expect(YARD).to receive(:parse).with(paths, [], YARD::Logger::ERROR)
      expect(YARD::Registry).to receive(:clear)
      allow(YARD::Registry).to receive(:all).with(:method).and_return([method_object])
    end

    it { should be_a(YARD::Cov::DocumentSet) }

    its(:length) { should be(1) }

    context 'first document' do
      subject { document_set.first }

      it { should be_a(YARD::Cov::Document) }

      its(:docstring) { should eql(docstring) }
    end
  end

  describe '.parse_string' do
    subject(:document_set) { described_class.parse_string(string) }

    let(:string)         { double('string', to_str: 'body')                      }
    let(:method_object1) { double(file: 'bar.rb', line: 2, docstring: 'barL2')   }
    let(:method_object2) { double(file: 'foo.rb', line: 1, docstring: 'fooL1')   }
    let(:method_object3) { double(file: 'foo.rb', line: 3, docstring: 'fooL3')   }
    let(:method_objects) { [method_object3, method_object1, method_object2]      }

    before do
      expect(YARD).to receive(:parse_string).with('body')
      expect(YARD::Registry).to receive(:clear)
      allow(YARD::Registry)
        .to receive(:all).with(:method).and_return(method_objects)
    end

    it { should be_a(YARD::Cov::DocumentSet) }

    its(:length) { should be(3) }

    context 'ordering' do
      subject { document_set.map(&:docstring) }
      it { should eql(%w[barL2 fooL1 fooL3]) }
    end

    context 'first document' do
      subject { document_set.first }

      it { should be_a(YARD::Cov::Document) }

      its(:docstring) { should eql('barL2') }
    end

    context 'when method one object does not have file information' do
      let(:docstring) { double('docstring') }

      let(:method_objects) do
        [
          method_object1,
          double(file: nil, line: nil, docstring: docstring)
        ]
      end

      it { should be_a(YARD::Cov::DocumentSet) }
      its(:length) { should be(1) }
    end
  end
end
