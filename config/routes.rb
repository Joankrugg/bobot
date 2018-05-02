Rails.application.routes.draw do
  resources :articles
  mount Facebook::Messenger::Server, at: "bot"
  mount Attachinary::Engine => "/attachinary"
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

