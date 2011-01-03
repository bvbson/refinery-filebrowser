class Admin::RefineryFilebrowsersController < Admin::BaseController
  protect_from_forgery :only => []
  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'


  def index
    
    
  end


  def get_tree
    @app = Dragonfly::App[:filebrowser]
    @parent = params[:dir] ||= "."
    selected_directory = "public/"+@parent
    @dir = RefineryFilebrowser.new(selected_directory).get_tree
    render :partial => "content"
  end



end
