module FilebrowserConfiguration

  def self.apply_configuration(app, *args)
    app.configure do |c|
      c.log = ::Rails.logger

      c.datastore.root_path = "#{::Rails.root}/public/system/dragonfly/#{::Rails.env}" if c.datastore.is_a?(Dragonfly::DataStorage::FileDataStore)
      
      c.analyser.register(Dragonfly::Analysis::FileCommandAnalyser)

      c.cache_duration = 3600*24*365*2                      # defaults to 1 year # (1 year)
      
      #c.infer_mime_type_from_file_ext = true                # defaults to true
      #c.url_host =nil
      c.url_path_prefix = '/media'                          # defaults to nil
      c.url_suffix = proc{|job|
        "/#{job.uid_basename}#{job.encoded_extname || job.uid_extname}"
      }

      #c.content_filename = "skeller"
      #c.content_filename = proc{|job, request|              # defaults to the original name, with modified ext if encoded
      #  "#{Time.now}.#{job.ext}"
      #}
      
      c.content_disposition = :attachment                   # defaults to nil (use the browser default)

      c.protect_from_dos_attacks = true                     # defaults to false - adds a SHA parameter on the end of urls
      if RefinerySetting.table_exists?
        #c.datastore = Dragonfly::DataStorage::FileBrowserDataStore.new
        c.protect_from_dos_attacks = true
        c.secret = RefinerySetting.find_or_set(:dragonfly_secret,
          Array.new(24) { rand(256) }.pack('C*').unpack('H*').first)
      end

      c.analyser.register(FileBrowserAnalyser)
      
      #c.processor
      #c.encoder.register(MyEncoder) do |e|                  # See 'Encoding' for more details
      #  e.some_value = 'geg'
      #end

      #c.generator.register(MyGenerator)                     # See 'Generators' for more details

    end
  end

end
