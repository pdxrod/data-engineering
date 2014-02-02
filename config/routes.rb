DataEngineering::Application.routes.draw do
  root 'uploads#index'
  patch '/users/:id', :to => 'uploads#index', :as => :user
end
