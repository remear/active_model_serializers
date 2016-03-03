module ActiveModelSerializers
  class SerializationContext
    class << self
      attr_accessor :url_helpers, :default_url_options
    end

    attr_reader :request_url, :query_parameters

    def initialize(request)
      @request_url = request.original_url[/\A[^?]+/]
      @query_parameters = request.query_parameters
    end
  end
end
