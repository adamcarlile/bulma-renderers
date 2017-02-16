module BulmaRenderers
  module Elements
    class Card

      def initialize(context, **options)
        @context = context
        @options = default_options.merge(options)
      end

      def header(title, **options)
        @header = BulmaRenderers::Elements::CardHeader.new(@context, title, options)
      end

      def header?
        !!@header
      end

      def image(image_url, **options)
        @image = BulmaRenderers::Elements::Image.new(@context, image_url, options)
      end

      def image?
        !!@image
      end

      def content(&block)
        return unless block_given?
        @content = @context.capture(&block)
        nil
      end

      def content?
        !!@content
      end

      def footer(&block)
        return unless block_given?
        @footer = BulmaRenderers::Elements::CardFooter.new(@context)
        yield(@footer)
        nil
      end

      def footer?
        !!@footer
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.div(html_options) do |card|
          card << @header.render if header?
          card.div(class: 'card-image')   { |div| div << @image.render } if image?
          card.div(class: 'card-content') { |div| div << @content }      if content?
          card << @footer.render if footer?
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
          out << 'card'
          out << @options[:class]
          out.compact.join(' ')
        end

        def default_options
          {
            class: nil
          }
        end

    end
  end
end

