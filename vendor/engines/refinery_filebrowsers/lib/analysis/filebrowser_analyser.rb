class FileBrowserAnalyser < Dragonfly::Analysis::ImageMagickAnalyser

  def image?(temp_object)
    begin
      identify(temp_object)
      val = true
    rescue => e
      val = false
    ensure
      if val.nil?
        val = false
      end
    end
  end

end
