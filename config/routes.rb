Rails.application.routes.draw do
  get 'welcome/index', as: :welcome
  root 'welcome#index'

  get 'customers', to: 'customers#index', as: :customers
  get 'customers/new', to: 'customers#new', as: :new_customer
  get 'customers/:id', to: 'customers#show', as: :customer
  post 'customers', to: 'customers#create', as: :create_customer
  get 'customers/:id/edit', to: 'customers#edit', as: :edit_customer
  patch 'customers/:id', to: "customers#update", as: :update_customer
  delete 'customers/:id', to: "customers#destroy", as: :delete_customer

  get 'books', to: 'books#index', as: :books
  get 'books/new', to: 'books#new', as: :new_book
  get 'books/:id', to: 'books#show', as: :book
  post 'books', to: 'books#create', as: :create_book
  get 'books/:id/edit', to: 'books#edit', as: :edit_book
  patch 'books/:id', to: "books#update", as: :update_book
  delete 'books/:id', to: "books#destroy", as: :delete_book

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
