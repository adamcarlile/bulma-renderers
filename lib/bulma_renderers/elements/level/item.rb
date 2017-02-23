module BulmaRenderers
  module Elements
    module Level
      class Item

        def initialize(context, content, **options)
          @context = context
          @content = content
          @options = default_options.merge(options)
        end

        def render
          @context.content_tag(@options[:tag], @content, html_options)
        end

        private

          def html_options
            {
              class: css_classes
            }
          end

          def css_classes
            out = []
            out << 'level-item'
            out << 'has-text-centered' if @options[:centered]
            out.compact.join(' ')
          end

          def default_options
            {
              centered: false,
              tag: :div
            }
          end

      end
    end
  end
end