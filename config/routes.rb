Rails.application.routes.draw do

  # match '/users/auth/:provider' => 'oauth_callbacks#passthru'
  # match '/admin' => 'admin/users#index', locale: I18n.default_locale

  # scope "/:locale" do

  #   devise_for :users, controllers: { omniauth_callbacks: "oauth_callbacks" }

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

  #     root to: 'users#index'
  #   end

  #   resource :user, controller: "user_profile" do
  #     resource :pswd, controller: "user_password"
  #   end

  #   root to: "welcome#index"
  # end

  # match '/formatizer' => 'utils#formatizer', locale: I18n.default_locale
  # match '/' => 'welcome#index', locale: I18n.default_locale


end