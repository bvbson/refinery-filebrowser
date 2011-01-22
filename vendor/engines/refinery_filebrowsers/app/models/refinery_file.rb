class RefineryFile < FileBrowserModel

  file_accessor :file


  alias :data :file

  def initialize(file_path)
    @file = file_path
  end

  def file_uid=(file_path)
    @file = file_path
  end

  def file_uid
    @file
  end
 
  def get_content(path=".")
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


  private

  def root
    if RefinerySetting.table_exists?
      RefinerySetting.find_or_set(
        :filebrowser_root,
        DEFAULT
      )
    else
      DEFAULT
    end
  end
end
