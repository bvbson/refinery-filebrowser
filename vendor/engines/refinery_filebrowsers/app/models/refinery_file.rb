class RefineryFile < FileBrowserModel

  #attr_accessor :cover_image, :cover_image_uid

  #delegate :size, :mime_type, :url, :width, :height, :to => :cover_image

  
  file_accessor :cover_image

  def initialize(attributes = {})
    attributes.each do |name,value|
      send("#{name}", value)
    end
  end

  def persisted?
    false
  end

  def cover_image=
    #puts "skeller write"
    # ...
  end

  def cover_image
    #puts "skeller read"
  end

  def skeller?
    true
  end

  
  def get_tree(path=".")
    path = "" if path.nil?
    @path = File.join(File.expand_path(@root), path)
    @dirs = []
    @files = []
    if File.exists?(@path)
      Dir.entries(@path).delete_if {|i| /(^\..*)/.match i }.each do |entry|
        if File.directory?(File.join(@path, entry))
          @dirs << entry
        end
        if File.file?(File.join(@path, entry))
          @files << entry
        end
      end
    end
    {:dirs => @dirs, :files => @files }
  end
end
