class Admin::RefineryFilebrowsersController < Admin::BaseController
  #protect_from_forgery :only => []

  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'

  def index

  end


  def get_tree
    @parent = params[:dir] ||= "."
    selected_directory = "public/"+@parent
    tree = RefineryFilebrowser.new(selected_directory).get_tree

    @dirs = tree[:dirs]
    @files = tree[:files]

    app = Dragonfly::App[:filebrowser]
    @file_urls = Array.new

    #@tree[:files].each do |file|
    
    @files.each do |file|
      job = app.fetch_file(File.join(Rails.root,selected_directory,file))
      #uid = app.store(File.new(File.join(Rails.root,selected_directory,file)))
      #job = app.fetch(uid)

      if job.image?
        @file_urls << job.process(:thumb, "56x56>").url
      else
        @file_urls << job.url
      end
    end

    render :partial => 'get_tree'
  end

end
