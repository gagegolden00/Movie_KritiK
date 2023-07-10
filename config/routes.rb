Rails.application.routes.draw do
  resources :movies do
    collection do
      resources :reviews do
        collection do
          get 'search', to: 'reviews#search', as: :reviews_search
        end
      end
    end
  end
  

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions' 
  }
  devise_scope :user do 
    root to: "pages#home"
    get '/email_sent', to: 'users/passwords#email_sent', as: :email_sent
  end
end
