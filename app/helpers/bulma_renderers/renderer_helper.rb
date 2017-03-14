module BulmaRenderers
  module RendererHelper

    def bulma_card(**options, &block)
      renderer = BulmaRenderers::Components::Card.new(self)
      yield(renderer) if block_given?
      renderer.render
    end

    def bulma_media_object(**options, &block)
      renderer = BulmaRenderers::Components::MediaObject.new(self, options)
      yield(renderer) if block_given?
      renderer.render
    end

    def bulma_message(title=nil, **options, &block)
      BulmaRenderers::Components::Message.new(self, title, options, &block).render
    end

    def bulma_level(**options, &block)
      renderer = BulmaRenderers::Components::Level.new(self, options)
      yield(renderer) if block_given?
      renderer.render
    end

    def bulma_nav(**options, &block)
      renderer = BulmaRenderers::Components::Nav.new(self)
      yield(renderer) if block_given?
      renderer.render
    end

    def bulma_image(url, **options)
      BulmaRenderers::Elements::Image.new(self, url, options).render
    end

    def bulma_tabs(**options, &block)
      renderer = BulmaRenderers::Components::Tabs.new(self, options)
      yield(renderer) if block_given?
      renderer.render
    end

  end
end