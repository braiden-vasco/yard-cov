require 'spec_helper'

describe YARD::Cov::Config, '#path=' do
  subject { described_class.new }

  before { subject.path = '/tmp/*.rb' }

  its(:path) { should eql('/tmp/*.rb') }
end
