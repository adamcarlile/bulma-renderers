module BulmaRenderers
  module Elements
    module Card
      class Footer

        def initialize(context)
          @context = context
          @links   = []
        end

        def link(title, href, **options)
          options = { scope: 'card-footer' }.merge(options)
          @links << BulmaRenderers::Elements::Link.new(@context, href, title, options)
          nil
        end

        def render
          xhtml = Builder::XmlMarkup.new target: out=(''), indent: 2
          xhtml.footer class: 'card-footer' do |footer|
            @links.each do |link|
              footer << link.render
            end
          end
          out.html_safe
        end

      end
    end
  end
end