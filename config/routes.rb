Takeout::Application.routes.draw do
  root :to => 'welcome#show'

  resource :welcome

  resources :music_members

  resources :music_credits

  resources :music_images

  resources :music_queue, :controller => 'music_queue'
  resource :music, :controller => 'music' do
    member do
      get 'artists'
      get 'albums'
      get 'tracks'
      get 'songs'
    end
  end
  resources :music_categories
  resources :music_genres, :only => [:index, :show] do
    member do
      get 'artists'
      get 'albums'
      get 'tracks'
      get 'songs'
    end
  end
  resources :music_songs do
    member do
      get 'stream'
      get 'cover'
    end
  end
  resources :music_albums
  resources :music_artists do
    member do
      get 'test'
    end
  end

  # Movies

  resources :movie_members do
    member do
      get 'movies'
    end
  end

  resources :movies, :only => [:index, :show] do
    member do
      get 'credits'
      get 'cast'
      get 'genres'
      get 'images'
      get 'stream'
    end
  end
  resources :movie_credits, :only => [:index, :show]
  resources :movie_collections, :only => [:index, :show]
  resources :movie_images, :only => [:index, :show]
  resources :movie_genres, :only => [:index, :show] do
    member do
      get 'movies'
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
