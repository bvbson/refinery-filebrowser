require 'rack/cache'
require 'dragonfly'
require 'refinery'

module Refinery
  module RefineryFilebrowsers
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_filebrowsers"
          plugin.activity = {:class => RefineryFilebrowser,
          :title => 'name'
        }
        end
      end
    end
  end
end
