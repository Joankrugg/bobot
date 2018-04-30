Rails.application.routes.draw do
  mount Facebook::Messenger::Server, at: "bot"
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

