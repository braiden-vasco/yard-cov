require 'spec_helper'

describe Yardstick::Rule, '.inherited' do
  let(:subclass) { Class.new(described_class) }

  after do
    Yardstick::Document.registered_rules.delete(subclass)
  end

  it 'registers rule' do
    expect(Yardstick::Document.registered_rules).to include(subclass)
  end
end
