module BulmaRenderers
  module Elements
    module Level
      class Section

        def initialize(context, name, **options)
          @context  = context
          @name     = name
          @options  = default_options.merge(options)
          @elements = []
        end

        def item(text=nil, **options, &block)
          options = item_options.merge(options)
          content = text 
          content = @context.capture(&block) if block_given?
          @elements << BulmaRenderers::Elements::Level::Item.new(@context, content, options)
          nil
        end

        def render
          xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
          xhtml.div(html_options) { |x| x << @elements.map(&:render).join("\n").html_safe }
          out.html_safe
        end

        private

          def html_options
            {
              class: css_classes
            }
          end

          def css_classes
            out = []
            out << "level-#{@name}"
            out << @options[:class]
            out.compact.join(' ')
          end

          def item_options
            @options.slice(:centered)
          end

          def default_options
            {

            }
          end

      end
    end
  end
end