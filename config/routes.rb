Rails.application.routes.draw do
  resources :todos
  root 'pages#home'
  get 'pages/home'
  get 'my_todos', to: 'todos#my_todos'
  get 'search_todo', to: 'todos#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
