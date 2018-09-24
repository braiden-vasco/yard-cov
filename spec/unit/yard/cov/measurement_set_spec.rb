require 'spec_helper'

RSpec.describe Yardstick::MeasurementSet do
  describe '#coverage' do
    subject { set.coverage }

    context 'when there are no measurements' do
      let(:set) { described_class.new }

      it { should be(1) }
    end

    context 'when there are measurements' do
      let(:set)          { described_class.new([measurement1, measurement2]) }
      let(:measurement1) { double('measurement', ok?: true)               }
      let(:measurement2) { double('measurement', ok?: false)              }

      it { should be_a(Rational) }

      it { should eq(0.5) }
    end
  end

  describe '#failed' do
    subject { set.failed }

    context 'when no failed measurements' do
      let(:set) { described_class.new }

      it { should be(0) }
    end

    context 'when a failed measurement' do
      let(:set)         { described_class.new([measurement])   }
      let(:measurement) { double('measurement', ok?: false) }

      it { should be(1) }
    end

    context 'when a failed measurement with a successful measurement' do
      let(:set)          { described_class.new([measurement1, measurement2]) }
      let(:measurement1) { double('measurement', ok?: false)              }
      let(:measurement2) { double('measurement', ok?: true)               }

      it { should be(1) }
    end
  end

  describe '#initialize' do
    context 'with no arguments' do
      subject { described_class.new }

      it { should be_a(described_class) }

      it { should be_a(Enumerable) }

      it { should be_empty }
    end

    context 'with measurements' do
      subject { described_class.new([measurement]) }

      let(:measurement) { double('measurement') }

      it { should be_a(described_class) }

      it { should be_a(Enumerable) }

      it { should include(measurement) }
    end
  end

  describe '#puts' do
    let(:document) { DocumentMock.new }

    let(:set) do
      described_class.new([failed.new, successful.new, successful.new])
    end

    let(:failed) do
      Class.new do
        def ok?
          false
        end

        def puts(io)
          io.puts('measurement info')
        end
      end
    end

    let(:successful) do
      Class.new do
        def ok?
          true
        end

        def puts(io)
          io.puts('measurement info')
        end
      end
    end

    describe 'with no arguments' do
      before do
        capture_stdout { set.puts }
      end

      it 'outputs the summary' do
        expect(@output).to eql([
          'measurement info',
          'measurement info',
          'measurement info',
          "\nYARD-Coverage: 66.6%  Success: 2  Failed: 1  Total: 3\n"
        ].join("\n"))
      end
    end

    describe 'with an object implementing #puts' do
      before do
        io = StringIO.new
        set.puts(io)
        io.rewind
        @output = io.read
      end

      it 'outputs the summary' do
        expect(@output).to eql([
          'measurement info',
          'measurement info',
          'measurement info',
          "\nYARD-Coverage: 66.6%  Success: 2  Failed: 1  Total: 3\n",
        ].join("\n"))
      end
    end
  end

  describe '#successful' do
    subject { set.successful }

    let(:set)          { described_class.new([measurement1, measurement2]) }
    let(:measurement1) { double('measurement', ok?: true)               }
    let(:measurement2) { double('measurement', ok?: false)              }

    it { should be(1) }
  end

  describe '#total' do
    subject { set.total }

    let(:set)         { described_class.new([measurement]) }
    let(:measurement) { double('measurement')              }

    it { should be(1) }
  end
end
