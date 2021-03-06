class RefineryFilebrowser < ActiveRecord::Base

  def initialize(root)
    @root = root
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

end
