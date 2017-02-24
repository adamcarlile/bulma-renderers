module BulmaRenderers
  module Components
    class Message

      def initialize(context, title=nil, **options, &block)
        @context = context
        @title = title
        @options = default_options.merge(options)
        @content = @context.capture(&block) if block_given?
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.article(html_options) do |message|
          message.div(class: 'message-header') { |header| header << @title } if header?
          message.div(class: 'message-body')   { |body| body << @content }
        end
        out.html_safe
      end

      private

        def header?
          !!@title
        end

        def html_options
          {
            class: css_classes
          }
        end

        def css_classes
          out = []
          out << 'message'
          out << 'is-dark' if @options[:dark]
          out << "is-#{@options[:type]}" if @options[:type]
          out.compact.join(' ')
        end

        def default_options
          {
            closable: false,
            dark: false,
            type: nil
          }
        end

    end
  end
end