class ImageflyApp < ActionController::Metal
  include ActionController::Rendering
  include AWS::S3
  append_view_path "#{Rails.root}/app/views"

  def index
    @parent = params[:dir] ||= "."
    puts @parent
    connect_s3
    bucket = Bucket.find("skeller")
    @paths = []
    @files = bucket.objects

    @files.each do |file|
      @paths << file.key
    end

    @dir = [["Order1","Order2","Order3",],["File1","File2","File3"]]
    render :text => "modifi 3 #{Rails.root}"
    #render "admin/imagefly_app/index"
  end

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