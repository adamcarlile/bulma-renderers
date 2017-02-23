module BulmaRenderers
  module Components
    class MediaObject

      def initialize(context, **options)
        @context = context
        @options = default_options.merge(options)
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.article(html_options) do |article|
          article.div(class: "media-left") do |left|
            left << @left_content
          end if left_content?
          article.div(class: "media-content") do |media_content|
            media_content.div(class: 'content') << @content if content?
            media_content << @nav.render if nav?
          end
        end
        out.html_safe
      end

      def content(&block)
        return unless block_given?
        @content = @context.capture(&block)
        nil
      end

      def content?
        !!@content
      end

      def left(&block)
        return unless block_given?
        @left_content = @context.capture(&block)
      end

      def left_content?
        !!@left_content
      end

      def nav(&block)
        return unless block_given?
        @nav = BulmaRenderers::Components::Nav.new(@context, class: 'level')
        yield(@nav)
        nil
      end

      def nav?
        !!@nav
      end

      private

        def html_options
          {
            class: css_classes
          }
        end

        def css_classes
          out = []
          out << 'media'
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

