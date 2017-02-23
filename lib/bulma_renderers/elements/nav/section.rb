module BulmaRenderers
  module Elements
    module Nav
      class Section

        def initialize(context, name, **options)
          @context  = context
          @name     = name
          @elements = []
          @options  = default_options.merge(options)
        end

        def link(href, title=nil, **options, &block)
          options = link_options.merge(options)
          @elements << BulmaRenderers::Elements::Link.new(@context, href, title, options, &block)
          nil
        end

        def render
          xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
          xhtml.div(html_options) {|x| x << @elements.map(&:render).join("\n") }
          out.html_safe
        end

        private

          def link_options
            {
              scope: @options[:scope],
              tabs: @options[:tabs]
            }.reject {|k, v| v.blank? }
          end

          def css_classes
            out = []
            out << [@options[:scope], @name].join('-')
            out << @options[:class]
            out.compact.join(' ')
          end

          def html_options
            {
              class: css_classes,
            }
          end

          def default_options
            {
              tabs: false
            }
          end

      end
    end
  end
end
