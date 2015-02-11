Rails.application.routes.draw do
   get "/article/user_details/make_superadmin/:user_id"=>"articles#make_superadmin", :as=> "super_admin" 
delete "/articles/user_profile/:user_id/delete_account/:user_id"=>"articles#delete_account",:as=> "delete_account"
  get "/articles/user_profile/:user_id/deactivate_account/:user_id"=>"articles#deactivate_account",:as=> "deactivate_account"
  get "/articles/user_profile/:user_id"=>"articles#user_profile",:as=> "user_profile" 
  get "/article/user_details/change_role/:user_id"=>"articles#change_role", :as=> "change_role" 
  delete "/articles/user_details/:user_id"=>"articles#delete_user", :as=> "delete_user" 
  get "/articles/user_details" => "articles#user_details", :as=> "user_details"
  get  "/articles/my_articles/:user_id" => "articles#my_articles", :as => "my_articles"
  delete "/articles/:article_id/attachments/:id" => "articles#delete_attachment", :as => "delete_attachment"
  devise_for :users
  #resources :users
  resources :articles do
    resources :comments

  end



  resources :tags
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'articles#index'

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
