module BulmaRenderers
  module Components
    class Nav

      def initialize(context, **options)
        @context  = context
        @sections = []
        @options  = default_options.merge(options)
      end

      def section(name, **options, &block)
        options = { scope: @options[:class] }.merge(options)
        section = BulmaRenderers::Elements::Nav::Section.new(@context, name, options)
        yield(section) if block_given?
        @sections << section
        nil
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.nav(html_options) do |nav|
          nav << @sections.map(&:render).join("\n")
        end
        out.html_safe
      end

      private

        def html_options
          {
            class: @options[:class]
          }
        end

        def default_options
          {
            class: 'nav',
            container: false
          }
        end

    end
  end
end