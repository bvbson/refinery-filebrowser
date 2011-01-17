class RefineryFilebrowser <FileBrowserModel

  def initialize(root)
    @root = root
  end


  file_accessor :file

  def file_uid=
    #puts "skeller write"
    # ...
  end

  def file_uid
    #puts "skeller read"
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
