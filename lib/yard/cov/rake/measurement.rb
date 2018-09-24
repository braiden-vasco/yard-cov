require 'rake'
require 'rake/tasklib'

require 'pathname'

require 'yard/cov'

module YARD::Cov
  module Rake
    # A rake task for measuring docs in a set of files
    class Measurement < ::Rake::TaskLib
      include Concord.new(:name, :config)

      # Initializes a Measurement task
      #
      # @example
      #   task = YARD::Cov::Rake::Measurement
      #
      # @param [Symbol] name
      #   optional task name
      #
      # @yieldparam [YARD::Cov::Config] config
      #   the config object
      #
      # @return [YARD::Cov::Rake::Measurement]
      #   the measurement task
      #
      # @api public
      def initialize(name = :yardcov_measure, options = {}, &block)
        super(name, Config.coerce(options, &block))

        define
      end

      # Measure the documentation
      #
      # @example
      #   task.yardcov_measure  # (output measurement report)
      #
      # @return [undefined]
      #
      # @api public
      def yardcov_measure
        config.output.write { |io| YARD::Cov.measure(config).puts(io) }
      end

      private

      # Define the task
      #
      # @return [undefined]
      #
      # @api private
      def define
        desc "Measure docs in #{config.path} with yard-cov"
        task(name) { yardcov_measure }
      end
    end
  end
end
