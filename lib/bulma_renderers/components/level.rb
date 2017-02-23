module BulmaRenderers
  module Components
    class Level

      def initialize(context, **options)
        @context  = context
        @options  = default_options.merge(options)
        @elements = []
      end

      def section(name, &block)
        section = BulmaRenderers::Elements::Level::Section.new(@context, name, @options)
        yield(section) if block_given?
        @elements << section
        nil
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
        xhtml.nav(html_options) do |nav|
          nav << @elements.map(&:render).join("\n").html_safe
        end
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
          out << 'level'
          out << @options[:class]
          out.compact.join(' ')
        end

        def item_options
          @options.slice(:centered)
        end

        def default_options
          {
            centered: false,
            mobile: false
          }
        end

    end
  end
end