class RefineryFileLight
  def initialize(file_path)
    @file = file_path
    app=Dragonfly::App[:filebrowser]
    @dragonfly = app.fetch_file @file
  end

  def file
    @dragonfly
  end
end
