module BulmaRenderers
  module Elements
    class Link

      def initialize(context, href, title=nil, **options, &block)
        @context = context
        @content = title
        @href    = href
        @options = default_options.merge(options)
        @content = @context.capture(&block) if block_given?
      end

      def render
        @context.link_to(content, @href, html_options)
      end

      private

        def content
          [icon, @content].compact.join("\n").html_safe
        end

        def css_classes
          out = []
          out << [@options[:scope], "item"].compact.join('-')
          out << 'is-tab' if tabs?
          out << 'is-active' if active?
          out << @options[:class]
          out.compact.join(' ')
        end

        def html_options
          {
            class: css_classes
          }
        end

        def icon
          @context.content_tag(:span, @context.fa_icon(@options[:icon]), class: 'icon') if icon?
        end

        def active?
          !@context.request.fullpath.match(/^#{Regexp.escape(@href).chomp('/')}(\/.*|\?.*)?$/).blank?
        end

        def tabs?
          !!@options[:tabs]
        end

        def icon?
          !!@options[:icon]
        end

        def default_options
          {
            scope: 'nav',
            icon: nil,
            tabs: false
          }
        end

    end
  end
end