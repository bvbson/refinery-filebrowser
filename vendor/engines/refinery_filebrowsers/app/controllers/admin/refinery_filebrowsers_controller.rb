class Admin::RefineryFilebrowsersController < Admin::BaseController
  #protect_from_forgery :only => []

  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'

  def index

  end


  def get_tree
    @parent = params[:dir] ||= "."
    selected_directory = "public/"+@parent
    @tree = RefineryFilebrowser.new(selected_directory).get_tree


    app = Dragonfly::App[:filebrowser]
    @image_urls = Array.new
    
    @tree[:files].each do |file|
      #job = app.fetch_file(File.join(Rails.root,selected_directory,file))
      uid = app.store(File.new(File.join(Rails.root,selected_directory,file)))
      job = app.fetch(uid)
      if job.image?
        @image_urls << job.process(:thumb, "56x56>").url
      end

        #if job.image?
      #  @image_urls << job.process(:thumb, "56x56>").url
      #end
    end

    render :partial => 'get_tree'
  end

end
