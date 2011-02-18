class Admin::RefineryFilebrowsersController < Admin::BaseController

  include AWS::S3
  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'

  protect_from_forgery :only => []

  def index
   
  end

  def show
    #render :text => "#{Rails.root}"
    #render :text => "#{params.inspect}"
    #id = params[:id] ||= "."
    id = CGI.unescape(params[:id])
    @file = RefineryFile.new(File.join("public", id))
    #@file = RefineryFile.new(File.join(paramsid))
    render :layout => 'show'
  end


  def get_tree

    if request.local?
      Refinery.s3_backend = false
    end
    
    if Refinery.s3_backend
      p "get s3 filebrowser bucket"

      p @parent=params[:dir] ||= "."
      connect_s3
      bucket = Bucket.find("skeller")
      @paths = []
      @files = bucket.objects(:prefix => @parent)

      @files.each do |file|
        @paths << file.key
      end

      @dir = [["Order1","Order2","Order3",],["File1","File2","File3"]]
      #render :text => "modifi 3 #{Rails.root}"
      #render "admin/imagefly_app/index"

      render :partial => 'get_tree_s3'
      

    else
      p "do normal filesystem public"


      @parent=params[:dir] ||= "."
      selected_directory = "public/"+CGI.unescape(CGI.unescape(@parent))

      tree = RefineryFilebrowser.new(selected_directory).get_content

      @dirs = tree[:dirs]

      file_names = tree[:files]
      @files = file_names

      #@files = Array.new
      #file_names.each do |file|
      #  @files << RefineryFileLight.new(File.join(Rails.root,selected_directory,file))
        #@files << RefineryFile.new(File.join(Rails.root,selected_directory,file))
      #end

      render :partial => "skeller"
      #render :partial => 'get_tree'
    end



  end

  def select
    @randomizer = params[:id]
    render :layout => 'show'
  end


  private

  def connect_s3
    begin
      Base.establish_connection!(
        :access_key_id => 'AKIAJ5LGOY6LQWGMRUGQ',
        :secret_access_key => 'lvP3Y5OImtc350l9dJkJoRRf51SoqHIVunYtkQ+P'
      )
      puts "Established connection to Amazon S3"
    rescue
      puts "Error by connection. Check your settings"
    end
  end
end
