Rails.application.routes.draw do


  get 'trgovina/index'

  get 'trgovina/show'

  get 'past_purchases/index'

  get 'past_purchases/show'

  get 'past_purchases/create'

  get 'past_purchases/edit'

  get 'past_purchases/update'

  get 'past_purchases/destroy'

  get 'carts_articles/index'

  get 'carts_articles/show'

  get 'carts_articles/new'

  get 'carts_articles/create'

  get 'carts_articles/edit'

  get 'carts_articles/update'

  get 'carts_articles/destroy'

  get 'shopping_carts/index'

  get 'shopping_carts/show'

  get 'shopping_carts/new'

  get 'shopping_carts/create'

  get 'shopping_carts/edit'

  get 'shopping_carts/update'

  get 'shopping_carts/destroy'

  get 'orders/index'

  get 'orders/show'

  get 'orders/new'

  get 'orders/create'

  get 'orders/edit'

  get 'orders/update'

  get 'orders/destroy'

  get 'shopping_carts/index'

  get 'shopping_carts/show'

  get 'clients/show'

  get 'articles/index'

  get 'articles/index_subcategories'

  get 'articles/show'

  get 'categories/index'

  get 'categories/show'

  get 'home/index'


  resources :articles
  resources :categories
  resources :clients
  resources :subcategories
  resources :ssubcategories
  resources :shopping_carts do
    put :destroy_single, on: :collection
  end
  resources :carts_articles do
    put :single, on: :collection
    put :create_single, on: :collection
  end
  resources :trgovina

  devise_for :users, controllers: { registrations: "users/registrations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
