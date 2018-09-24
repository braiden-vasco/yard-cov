require 'spec_helper'

require 'yard/cov/rake/measurement'

describe Yardstick::Rake::Measurement, '#yardcov_measure' do
  subject { described_class.new(:yardcov_measure, options).yardcov_measure }

  let(:config)        { double('config', path: 'tmp', output: report_writer) }
  let(:report_writer) { double('report writer')                              }
  let(:options)       { double('options')                                    }
  let(:measurements)  { double('measurements')                               }
  let(:io)            { double('io')                                         }

  it 'writes results' do
    allow(Yardstick::Config)
      .to receive(:coerce).with(options).and_return(config)
    allow(Yardstick)
      .to receive(:measure).with(config).and_return(measurements)
    allow(report_writer).to receive(:write).and_yield(io)
    expect(measurements).to receive(:puts).with(io)
    subject
  end
end
