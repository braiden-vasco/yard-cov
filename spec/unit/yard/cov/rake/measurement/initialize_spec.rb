require 'spec_helper'

require 'yard/cov/rake/measurement'

describe YARD::Cov::Rake::Measurement, '#initialize' do
  context 'with custom arguments' do
    subject(:task) { described_class.new(:measure, options) }

    let(:config)  { YARD::Cov::Config.new }
    let(:options) { double('options')     }

    before do
      allow(YARD::Cov::Config)
        .to receive(:coerce).with(options).and_return(config)
    end

    context 'when valid options' do
      it { should be_a(described_class) }

      it 'creates rake task with given name' do
        subject
        expect(Rake::Task['measure']).to be_kind_of(Rake::Task)
      end

      it 'calls yardcov_measure when rake task is executed' do
        subject
        expect(task).to receive(:yardcov_measure)
        Rake::Task['measure'].execute
      end

      it 'includes the threshold in the task name' do
        task
        expect(Rake.application.last_description)
          .to eql('Measure docs in lib/**/*.rb with yard-cov')
      end
    end
  end

  context 'when with default arguments' do
    subject { described_class.new }

    it { should be_a(described_class) }

    it 'assigns yardcov_measure as the name' do
      subject
      expect(Rake::Task['yardcov_measure']).to be_kind_of(Rake::Task)
    end
  end

  context 'when block provided' do
    subject(:task) do
      described_class.new do |config|
        @yield = config
      end
    end

    it { should be_a(described_class) }

    it 'yields to Config' do
      task
      expect(@yield).to be_instance_of(YARD::Cov::Config)
    end
  end
end
