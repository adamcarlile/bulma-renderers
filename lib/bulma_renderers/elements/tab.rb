module BulmaRenderers
  module Elements
    class Tab

      def initialize(context, name, **options, &block)
        @context   = context
        @name      = name
        @content   = @context.capture(&block) if block_given?
        @options   = default_options.merge(options)
      end

      def link
        @link ||= @context.content_tag(:li, BulmaRenderers::Elements::Link.new(@context, link_to, @name, link_options).render, tab_options)
      end

      def content
        return unless @content
        @context.content_tag(:div, @content, content_html_options)
      end

      private

        def link_to
          "##{reference}"
        end

        def css_classes
          out = []
          out << 'is-active' if active?
          out << @options[:class]
          out.compact.join(' ')
        end

        def content_html_options
          {
            class: css_classes,
            id: reference
          }
        end

        def tab_options
          {
            class: css_classes
          }
        end

        def link_options
          {
            icon: nil,
            tabs: true,
            scope: nil,
          }.merge(@options.slice(:icon, :tabs, :scope))
        end

        def reference
          @reference ||= [@name.parameterize, SecureRandom.hex(4)].join('-')
        end

        def active?
          !!@options[:active]
        end

        def default_options
          {
            active: false
          }
        end

    end
  end
end