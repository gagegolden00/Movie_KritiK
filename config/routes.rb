Rails.application.routes.draw do
  resources :movies do
    collection do
      resources :reviews do
        collection do
          get "search", to: "reviews#search", as: :reviews_search
        end
      end
    end
  end

  devise_for :users, controllers: {
            passwords: "users/passwords",
            registrations: "users/registrations",
            sessions: "users/sessions",
          }
  devise_scope :user do
    root to: "pages#home"
    get "/account", to: "pages#account", as: :account
    get "/email_sent", to: "users/passwords#email_sent", as: :email_sent

    get "/user/edit_account", to: "users/registrations#edit_account", as: :edit_account
    get "/user/edit_password", to: "users/registrations#edit", as: :edit_password
  end
end
