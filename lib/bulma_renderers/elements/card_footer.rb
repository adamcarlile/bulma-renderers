module BulmaRenderers
  module Elements
    class CardFooter

      def initialize(context)
        @context = context
        @links   = []
      end

      def link(title, href)
        @links << @context.link_to(title, href, class: 'card-footer-item')
      end

      def render
        xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
        xhtml.footer class: 'card-footer' do |footer|
          @links.each do |link|
            footer << link
          end
        end
        out.html_safe
      end

    end
  end
end