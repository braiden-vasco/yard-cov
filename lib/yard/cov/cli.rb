require 'optparse'

module YARD::Cov
  # Handle the command line interface
  class CLI
    # Parse the command line options, and run the command
    #
    # @example
    #   YARD::Cov::CLI.run(%w[ article.rb ])  # => [ Measurement ]
    #
    # @param [Array] args
    #   arguments passed in from the command line
    #
    # @return [YARD::Cov::MeasurementSet]
    #   the measurement for each file
    #
    # @api public
    def self.run(*args)
      measurements = YARD::Cov.measure(parse_config(args))
      measurements.puts
      measurements
    end

    # Parse the options provided from the command-line
    #
    # @param [Array<String>] args
    #   the command-line options
    #
    # @return [Config]
    #   the list of files, and options parsed from the command-line
    #
    # @api private
    def self.parse_config(args)
      args << '--help' if args.empty?
      option_parser.parse!(args)
      Config.new(path: args)
    rescue OptionParser::InvalidOption => error
      display_exit(error)
    end

    # Return an OptionParser instance for the command-line app
    #
    # @return [YARD::Cov::OptionParser]
    #   the option parser instance
    #
    # @api private
    def self.option_parser
      opts = OptionParser.new
      opts.on_tail('-v', '--version', 'print version information and exit') { display_exit("#{opts.program_name} #{VERSION}") }
      opts.on_tail('-h', '--help',    'display this help and exit')         { display_exit(opts) }
    end

    # Display a message and exit
    #
    # @param [#to_str] message
    #   the message to display
    #
    # @return [undefined]
    #
    # @api private
    def self.display_exit(message)
      puts message
      exit
    end

    class << self
      private :option_parser, :parse_config, :display_exit
    end
  end
end
