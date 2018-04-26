Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  get '/me' => 'current_user#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
      resources :tests do
          resources :questions do
              resources :answers
          end
      end
  end

end
