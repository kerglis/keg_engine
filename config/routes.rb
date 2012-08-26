Rails.application.routes.draw do

  # match '/users/auth/:provider' => 'oauth_callbacks#passthru'
  # match '/admin' => 'admin/users#index', :locale => I18n.default_locale

  # scope "/:locale" do

  #   devise_for :users, :controllers => { :omniauth_callbacks => "oauth_callbacks" }

  #   namespace :admin do

  #     resources :users do
  #       member do
  #         get :swap
  #         get :change_password
  #       end
  #       collection do
  #         post :filter
  #       end
  #     end

  #     root :to => 'users#index'
  #   end

  #   resource :user, :only => [ :show, :update ]

  #   root :to => "welcome#index"
  # end

  # match '/' => 'welcome#index', :locale => I18n.default_locale

end