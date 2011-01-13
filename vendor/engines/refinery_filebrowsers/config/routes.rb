Refinery::Application.routes.draw do
  match '/media/(*dragonfly)', :to => Dragonfly[:filebrowser]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
      resources :refinery_filebrowsers, :only => [:index] do
        post :get_tree, :on => :collection
      end
  end
end
