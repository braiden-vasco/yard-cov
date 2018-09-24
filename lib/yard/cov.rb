# frozen_string_literal: true

require 'set'
require 'pathname'
require 'delegate'

require 'yard'
require 'yard/logging'
require 'concord'
require 'ice_nine'
require 'adamantium'
require 'abstract_type'

require 'yard/cov/ordered_set'
require 'yard/cov/measurement'
require 'yard/cov/decorator'

require 'yard/cov/config'
require 'yard/cov/report_output'
require 'yard/cov/document'

require 'yard/cov/rule'
require 'yard/cov/rule_config'
require 'yard/cov/rule_description'
require 'yard/cov/rule_description/token'
require 'yard/cov/rule_description/formatter'
require 'yard/cov/rule_description/classifier'
require 'yard/cov/rule_description/tokenizer'
require 'yard/cov/rules/api_tag'
require 'yard/cov/rules/example_tag'
require 'yard/cov/rules/summary'
require 'yard/cov/rules/return_tag'

require 'yard/cov/measurement_set'
require 'yard/cov/document_set'
require 'yard/cov/processor'
require 'yard/cov/parser'

require 'yard/cov/yard_ext'

require 'yard/cov/version'

# Measure YARD documentation coverage
module YARD::Cov
  ROOT = Pathname(__FILE__).dirname.parent.expand_path.freeze

  # Measure a list of files
  #
  # @example
  #   config = YARD::Cov::Config.coerce(path: 'article.rb')
  #   YARD::Cov.measure(config)  # => [ MeasurementSet ]
  #
  # @param [Config] config
  #   optional configuration
  #
  # @return [YARD::Cov::MeasurementSet]
  #   the measurements for each file
  #
  # @api public
  def self.measure(config = Config.new)
    Processor.new(config).process
  end

  # Measure a string of code and YARD documentation
  #
  # @example
  #   string = "def my_method; end"
  #
  #   YARD::Cov.measure_string(string)  # => [ Measurement ]
  #
  # @param [#to_str] string
  #   the string to measure
  # @param [Config] config
  #   optional configuration
  #
  # @return [YARD::Cov::MeasurementSet]
  #   the measurements for the string
  #
  # @api public
  def self.measure_string(string, config = Config.new)
    Processor.new(config).process_string(string)
  end

  # Round percentage to 1/10th of a percent
  #
  # @param [Float] percentage
  #   the percentage to round
  #
  # @return [Float]
  #   the rounded percentage
  #
  # @api private
  def self.round_percentage(percentage)
    (percentage * 10).floor / 10.0
  end
end
