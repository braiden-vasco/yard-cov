require 'spec_helper'

RSpec.describe YARD::Cov::RuleDescription::Formatter::Null, '#format' do
  subject { described_class.new(description).format }

  let(:description) do
    YARD::Cov::RuleDescription.new([
      YARD::Cov::RuleDescription::Token::Subject.new('important'),
      YARD::Cov::RuleDescription::Token::Text.new(' recommended '),
      YARD::Cov::RuleDescription::Token::Option.new('value'),
    ])
  end

  it { should eql('important recommended value') }
  it { should be_a(String) }
end
