require 'spec_helper'

RSpec.describe YARD::Cov::RuleDescription::Formatter, '#format' do
  subject { described_class.new(description).format }

  let(:description) do
    [
      YARD::Cov::RuleDescription::Token::Subject.new('important'),
      YARD::Cov::RuleDescription::Token::Text.new(' recommended '),
      YARD::Cov::RuleDescription::Token::Option.new('value')
    ]
  end

  it do
    should eql("\e[1;31mimportant\e[0m recommended \e[4;33mvalue\e[0m")
  end

  it { should be_a(String) }
end
