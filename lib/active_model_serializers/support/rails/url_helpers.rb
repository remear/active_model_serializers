module ActiveModelSerializers
  module Support
    module UrlHelpers
      module Rails
        extend ActiveSupport::Concern
        include ::Rails.application.routes.url_helpers

        included do
          def default_url_options
            ::ActionMailer::Base.default_url_options
          end
        end
      end
    end
  end
end