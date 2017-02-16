module BulmaRenderers
  module Elements
    class CardHeader

      def initialize(context, title, **options)
        @context = context
        @title   = title
        @options = default_options.merge(options)
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.header class: 'card-header' do |header|
          header << title_html
          header << icon_html
        end
        out.html_safe
      end

      private

        def title_html
          @context.content_tag(:p, title, class: 'card-header-title')
        end

        def icon_html
          @context.content_tag(:a, @context.fa_icon(@options[:icon]), class: 'card-header-icon')
        end

        def default_options
          {
            icon: 'angle-down'
          }
        end

    end
  end
end