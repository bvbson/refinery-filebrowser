class Admin::RefineryFilebrowsersController < Admin::BaseController

  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'

  protect_from_forgery :only => []

  def index
    
  end

  def show
    #render :text => "#{Rails.root}"
    #render :text => "#{params.inspect}"
    #id = params[:id] ||= "."
    id = CGI::unescape(params[:id])
    @file = RefineryFile.new(File.join("public", id))
      #@file = RefineryFile.new(File.join(paramsid))
    render :layout => 'show'
  end


  def get_tree
    @parent = params[:dir] ||= "."
    selected_directory = "public/"+@parent
    tree = RefineryFilebrowser.new(selected_directory).get_content

    @dirs = tree[:dirs]

    file_names = tree[:files]
    @files = Array.new
    file_names.each do |file|
      @files << RefineryFile.new(File.join(Rails.root,selected_directory,file))
    end
    p params.inspect
    render :partial => 'get_tree'
  end

end
