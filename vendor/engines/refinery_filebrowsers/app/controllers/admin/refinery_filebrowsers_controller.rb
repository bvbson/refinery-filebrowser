class Admin::RefineryFilebrowsersController < Admin::BaseController
  #protect_from_forgery :only => []
  #crudify :refinery_filebrowser,
  #        :title_attribute => 'name'


  def index
    
    
  end


  def get_tree
    app = Dragonfly::App[:images]

    image = app.generate(:plasma, 600, 400, :gif)

    #uid = app.store(File.new('/home/neo/Desktop/images/dortmund.jpg'))


    #puts app.url_for(app.fetch("#{uid}"),'100x50#ne', :jpg)

    #puts @url = app.fetch("17_50_33_54_home_slide_2.jpg").url

    #puts url = url_for(job, "320x240")

    #puts url = app.url_for(job,"320x240#")
    #@url = app.fetch(uid).thumb('400x300')
    #@url = app.fetch(uid).url

    #@url=Dragonfly::App[:filebrowser].url_for('2011/01/03/19_01_36_833_dortmund.jpg', '100x50#')
    #@url = app.fetch("2011/01/03/19_01_36_833_dortmund.jpg")

    #@url = Dragonfly::App[:images].url(File.new('/home/neo/Desktop/images/dortmund.jpg'),'100x50#', :jpg).url
    #@url = app.store(File.new('/images/dortmund.jpg'))
    #@url = File.new('images/dortmund.jpg')
    #@url = app.store(File.new('/home/neo/Desktop/images/dortmund.jpg'))

    #@url =app.thumb(File.new('/home/neo/Desktop/images/dortmund.jpg'), '100x50#ne')

    #app = Dragonfly::App[:filebrowser]
    #uid = app.store(File.new('/home/neo/Desktop/images/dortmund.jpg'))
    #@url = "HAllo"
    #@url = app.fetch(uid).thumb('400x300')

    @parent = params[:dir] ||= "."
    selected_directory = "public/"+@parent
    @dir = RefineryFilebrowser.new(selected_directory).get_tree
    render :partial => "content"
  end

  def skeller
    #app = Dragonfly::App[:filebrowser]
    #uid = app.store(File.new('/home/neo/Desktop/images/dortmund.jpg'))
    #@url = app.fetch(uid).thumb('400x300').url
    #puts app.config
    #puts image
    #@url = app.url_for(image)
  end

  def skeller2
    #app = Dragonfly:App[:filebrowser]
    #uid = app.store(File.new('/home/neo/Desktop/images/dortmund.jpg'))
    #@url = app.fetch(uid).thumb('400x300').url
    #puts app.config
    #puts image
    #@url = app.url_for(image)
  end


end
