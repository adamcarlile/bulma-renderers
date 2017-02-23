module BulmaRenderers
  module Elements
    class Image

      def initialize(context, image_url, **options)
        @context   = context
        @image_url = image_url
        @options   = default_options.merge(options)
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.figure(html_options) do |figure|
          figure << @context.image_tag(@image_url, image_options)
        end
        out.html_safe
      end

      private

        def html_options
          {
            class: css_classes
          }
        end

        def image_options
          {
            alt: @options[:alt]
          }.reject {|k, v| v.blank?}
        end

        def css_classes
          out = []
          out << 'image'
          out << size_class
          out.compact.join(' ')
        end

        def size_class
          "is-#{@options[:size]}"
        end

        def default_options
          {
            size: :square,
            alt: nil
          }
        end

    end
  end
end