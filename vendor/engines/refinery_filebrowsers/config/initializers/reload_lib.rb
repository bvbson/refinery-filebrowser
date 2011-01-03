puts file = File.join(Rails.root, 'vendor', 'engines', 'refinery-filebrowsers', 'lib', 'imagefly_app.rb')
if Rails.env == "development"
  lib_reloader = ActiveSupport::FileUpdateChecker.new(Dir["#{file}"], true) do
    Rails.application.config.autoload_paths << file
    Rails.application.reload_routes! # or do something better here
  end

  ActionDispatch::Callbacks.to_prepare do
    #puts lib_reloader.last_update_at
    #puts "##########"
    #puts lib_reloader.paths
    lib_reloader.execute_if_updated
    #puts Rails.application.config.inspect
    #Rails.application.config.autoload_paths << File.join(Rails.application.config.root, "lib")
  end
end