Rails.application.routes.draw do

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do 
    root to: "pages#home"
  end
end
