require 'rack/cache'
require 'dragonfly'
require 'refinery'
require 'imagefly_app'
require 'analysis/filebrowser_analyser'
require 'model/filebrowser'

module Refinery
  module RefineryFilebrowsers
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      initializer 'refinery-filebrowser-with-dragonfly' do |app|
        app_filebrowser = Dragonfly::App[:filebrowser]
        app_filebrowser.configure_with(:imagemagick)
        app_filebrowser.configure_with(:rails) do |c|
          if RefinerySetting.table_exists?
            #c.datastore = Dragonfly::DataStorage::FileBrowserDataStore.new
            c.protect_from_dos_attacks = true
            c.secret = RefinerySetting.find_or_set(:dragonfly_secret,
              Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
          end
        end

        if Refinery.s3_backend
          app_filebrowser.configure_with(:heroku, ENV['S3_BUCKET']) do |c|
            c.datastore = FilebrowserS3DataStore.new
          end
        end

        app_filebrowser.define_macro(FileBrowserModel, :file_accessor)


        app_filebrowser.analyser.register(FileBrowserAnalyser)
        #app_filebrowser.analyser.register(Dragonfly::Analysis::ImageMagickAnalyser)
        #app_filebrowser.analyser.register(Dragonfly::Analysis::FileCommandAnalyser)

        # This url_suffix makes it so that dragonfly urls work in traditional
        # situations where the filename and extension are required, e.g. lightbox.
        # What this does is takes the url that is about to be produced e.g.
        # /system/images/BAhbB1sHOgZmIiMyMDEwLzA5LzAxL1NTQ19DbGllbnRfQ29uZi5qcGdbCDoGcDoKdGh1bWIiDjk0MngzNjAjYw
        # and adds the filename onto the end (say the image was 'refinery_is_awesome.jpg')
        # /system/images/BAhbB1sHOgZmIiMyMDEwLzA5LzAxL1NTQ19DbGllbnRfQ29uZi5qcGdbCDoGcDoKdGh1bWIiDjk0MngzNjAjYw/refinery_is_awesome.jpg
        # Officially the way to do it, from: http://markevans.github.com/dragonfly/file.URLs.html
        app_filebrowser.url_suffix = proc{|job|
          "/#{Time.now.year}_#{Time.now.month}_#{Time.now.day}_#{job.encoded_extname || job.uid_extname}"
        }
        app_filebrowser.content_filename = proc{|job,response|
          "#{Time.now.year}_#{Time.now.month}_#{Time.now.day}_.#{job.ext}"
        }

        app.config.middleware.insert_after 'Rack::Lock', 'Dragonfly::Middleware', :filebrowser, '/system/dragonfly'

        app.config.middleware.insert_before 'Dragonfly::Middleware', 'Rack::Cache', {
          :verbose     => Rails.env.development?,
          :metastore   => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'meta')}",
          :entitystore => "file:#{Rails.root.join('tmp', 'dragonfly', 'cache', 'body')}"
        }
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
