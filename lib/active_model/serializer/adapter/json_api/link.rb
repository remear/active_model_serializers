require 'active_model_serializers/helpers'

module ActiveModel
  class Serializer
    module Adapter
      class JsonApi
        class Link
          def initialize(serializer, value, options)
            @object = serializer.object
            @scope = serializer.scope
            @context = options[:serialization_context]

            # Use the return value of the block unless it is nil.
            if value.respond_to?(:call)
              @value = instance_eval(&value)
            else
              @value = value
            end
          end

          def href(value)
            @href = value
            nil
          end

          def meta(value)
            @meta = value
            nil
          end

          def as_json
            return @value if @value

            hash = {}
            hash[:href] = @href if @href
            hash[:meta] = @meta if @meta

            hash
          end

          protected

          attr_reader :object, :scope
        end
      end
    end
  end
end
