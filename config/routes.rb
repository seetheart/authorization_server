Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authorize', to: 'authorization#authorize'
      resources :app do
        resources :role
      end
      resources :role do
        resources :permission
      end
    end
  end

  match "*path", to: "errors#not_found", via: :all
end
