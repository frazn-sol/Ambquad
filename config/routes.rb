Ambquad::Application.routes.draw do
  
  devise_for :clients, controllers: { registrations: "clients/registrations", confirmations: 'clients/confirmations' }, :path => '', :path_names => {:sign_in => 'sign_in', :sign_up => 'sign_up'}

  resources :clients do 
    collection do
      get "clients/sign_out"  => "devise/sessions#destroy", :as => :destroy_client_session
      get :error
    end
  end

  get "/:id" => "clients#show", :as => :show_path

  devise_for :admins do 
    get "/sign_out"  => "devise/sessions#destroy", :as => :destroy_admin_session
  end

  resources :admins do
    member do
      put :update_client
      get :edit_project
      put :update_project
      delete :delete_project
      get :edit_code
      put :update_code
      delete :delete_code
      put :reset_password
    end

    collection do 
      get :error
      get :forgot_password
      put :validate_project
      post :validate_project
      post :create_client
      get :new_project
      post :create_project
      get :code
      post :save_code
      get :clients
      get :client
    end
  end

  root :to => "admins#index"

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
