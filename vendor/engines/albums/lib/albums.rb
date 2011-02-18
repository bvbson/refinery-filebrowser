require 'refinery'

module Refinery
  module Albums
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "albums"
          plugin.activity = {:class => Album,
          :title => 'name'
        }
        end
      end
    end
  end
end
