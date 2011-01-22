class FileBrowserModel
  extend ActiveModel::Callbacks

  define_model_callbacks :save, :destroy

  def save
    _run_save_callbacks {
      # do some saving!
    }
  end

  def destroy
    _run_destroy_callbacks {
      # do some destroying!
    }
  end

end
