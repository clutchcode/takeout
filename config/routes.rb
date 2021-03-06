Takeout::Application.routes.draw do
  root :to => 'welcome#show'

  resource :welcome

  resource :settings do
    member do
      get 'scan'
      get 'music_scan'
      get 'movies_scan'
    end
  end

  resources :music_members do
    member do
      get 'artists'
    end
    collection do
      get 'performers'
    end
  end

  resources :music_credits

  resources :music_images

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
  resources :music_albums, :only => [:index, :show] do
    collection do
      get 'released'
      get 'modified'
      get 'added'
    end
  end
  resources :music_artists do
    member do
      get 'songs'
    end
  end
  resources :music_search, :only => [:index]

  # Movies

  resources :movie_members do
    member do
      get 'movies'
    end
    collection do
      get 'actors'
      get 'directors'
      get 'producers'
      get 'writers'
    end
  end
  match 'movie_actors' => 'movie_members#actors'
  match 'movie_directors' => 'movie_members#directors'
  match 'movie_producers' => 'movie_members#producers'
  match 'movie_writers' => 'movie_members#writers'

  resources :movies, :only => [:index, :show] do
    member do
      get 'credits'
      get 'cast'
      get 'genres'
      get 'images'
      get 'stream'
    end
    collection do
      get 'released'
      get 'modified'
      get 'added'
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
