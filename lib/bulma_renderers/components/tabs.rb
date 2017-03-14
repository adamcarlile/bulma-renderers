module BulmaRenderers
  module Components
    class Tabs

      def initialize(context, **options)
        @context  = context
        @tabs     = []
        @options  = default_options.merge(options)
      end
    
      def tab(name, **options, &block)
        @tabs << BulmaRenderers::Elements::Tab.new(@context, name, options, &block)
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.div(class: 'tab-container') do |container|
          xhtml.div(tabs_html_options) do |tabs|
            tabs.ul {|ul| ul << @tabs.map(&:link).compact.join("\n")}
          end
          xhtml.div(class: 'tab-content') {|div| div << @tabs.map(&:content).compact.join("\n") }
        end
        out.html_safe
      end

      private

        def tabs_html_options
          {
            class: css_classes
          }
        end

        def css_classes
          out = []
          out << 'tabs'
          out << size
          out << position
          out << 'is-boxed' if boxed?
          out << 'is-toggle' if toggle?
          out << 'is-fullwidth' if full_width?
          out.compact.join(' ')
        end

        def default_options
          {
            toggle: false,
            size: nil,
            position: nil,
            boxed: false,
            full_width: false,
          }
        end

        def size
          return unless @options[:size]
          "is-#{@options[:size]}"
        end

        def position
          return unless @options[:position]
          "is-#{@options[:position]}"
        end

        def full_width?
          !!@options[:full_width]
        end

        def toggle?
          !!@options[:toggle]
        end

        def boxed?
          !!@options[:boxed]
        end

    end
  end
end