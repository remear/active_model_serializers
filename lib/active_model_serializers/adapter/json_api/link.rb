require 'active_support/core_ext/module/delegation'

module ActiveModelSerializers
  module Adapter
    class JsonApi
      # link
      # definition:
      #  oneOf
      #    linkString
      #    linkObject
      #
      # description:
      #   A link **MUST** be represented as either: a string containing the link's URL or a link
      #   object."
      # structure:
      #   if href?
      #     linkString
      #   else
      #     linkObject
      #   end
      #
      # linkString
      # definition:
      #   URI
      #
      # description:
      #   A string containing the link's URL.
      # structure:
      #  'http://example.com/link-string'
      #
      # linkObject
      # definition:
      #   JSON Object
      #
      # properties:
      #   href (required) : URI
      #   meta
      # structure:
      #   {
      #     href: 'http://example.com/link-object',
      #     meta: meta,
      #   }.reject! {|_,v| v.nil? }
      class Link
        include SerializationContext.url_helpers
        delegate :default_url_options, to: SerializationContext

        def initialize(serializer, value)
          @object = serializer.object
          @scope = serializer.scope
          @href = nil
          @meta = nil

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
