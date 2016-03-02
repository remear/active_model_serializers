module ActiveModelSerializers
  module Support
    module UrlHelpers
      def url_for(options)
        fail 'template method'
      end
      def default_url_options
        fail 'template method'
      end
    end
  end
end