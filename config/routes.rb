Rails.application.routes.draw do

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  root 'pages#home'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  resources :users, :sessions, :pages, :password_resets

  resources :families, concerns: :paginatable do
    get   'approval_letter' => 'families#approval_letter'
    post  'approval_letter' => 'families#approval_letter'
    collection { get :search }
    resources :updates
    resources :donations
    resources :grants
    match 'donations/cancel/:token' => 'donations#cancel_monthly_donation', via: :get
  end

  get 'dashboard' => 'pages#dashboard'
  get 'about' => 'pages#about'
  get 'faq' => 'pages#faq'
  get 'contact' => 'pages#contact'
  get 'unsub' => 'pages#unsub'

  get 'donate' => 'donations#new'
  resources :charity do
    resources :donations
    match 'donations/cancel/:token' => 'donations#cancel_monthly_donation', via: :get
  end

  get 'thanks' => 'donations#thanks'

  namespace :admin do
    get '/' => 'pages#dashboard'
    resources :users
    resources :donations
    resources :grants do
      get 'deny_grant' => 'grants#grant_denied'
    end
    resources :families do
      collection { get :search }
      resources :donations
      resources :updates
      resources :grants
      get 'toggle_approval', on: :member
      get 'toggle_visibility', on: :member
    end
    resources :charities
    resources :pages
  end

  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', :as => :auth_at_provider

  get 'oauths/oauth'
  get 'oauths/callback'

  match '/:slug' => 'pages#show', via: [:get, :post]

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

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
