module YARD::Cov
  # Handle procesing a docstring or path of files
  class Processor
    include Concord.new(:config)

    # Measure files specified in the config
    #
    # @return [YARD::Cov::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def process
      Parser.parse_paths(paths).measure(config)
    end

    # Measure string provided
    #
    # @param [#to_str] string
    #   the string to measure
    #
    # @return [YARD::Cov::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def process_string(string)
      Parser.parse_string(string).measure(config)
    end

    private

    # Return config's possible paths
    #
    # @return [Array<String>]
    #
    # @api private
    def paths
      Array(config.path).map(&:to_s)
    end
  end
end
