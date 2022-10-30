Rails.application.routes.draw do
  resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "tasks#index"

  post 'tasks/send_mail', to: 'tasks#send_mail'
end
