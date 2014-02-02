DataEngineering::Application.routes.draw do
  root 'uploads#index'
  get '/users/:id', :to => 'uploads#index', :as => :user
end
