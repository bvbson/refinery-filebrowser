Refinery::Application.routes.draw do
  resources :albums

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :albums do
      collection do
        post :update_positions
      end
    end
  end
end
