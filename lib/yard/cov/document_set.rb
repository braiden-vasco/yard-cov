module YARD::Cov
  # A set of documents
  class DocumentSet < OrderedSet
    # Measure documents using given config
    #
    # @return [YARD::Cov::MeasurementSet]
    #   a collection of measurements
    #
    # @api private
    def measure(config)
      reduce(MeasurementSet.new) do |set, document|
        set.merge(Document.measure(document, config))
      end
    end
  end
end
