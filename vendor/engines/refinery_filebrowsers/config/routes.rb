Refinery::Application.routes.draw do
  resources :refinery_filebrowsers

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :refinery_filebrowsers do
      collection do
        post :update_positions
      end
    end
  end
end
