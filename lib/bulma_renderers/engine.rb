module BulmaRenderers
  class Engine < ::Rails::Engine
    config.to_prepare do
      ApplicationController.helper(BulmaRenderers::RendererHelper)
    end
  end
end