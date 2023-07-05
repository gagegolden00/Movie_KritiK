Rails.application.routes.draw do
  resources :movies do
    collection do
      get :search
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
