Rails.application.routes.draw do
  get 'welcome/home', as: :welcome
  root 'welcome#home'

  #CUSTOMERS
  get 'customers', to: 'customers#index', as: :customers

  get 'customers/new', to: 'customers#new', as: :new_customer
  post 'customers', to: 'customers#create', as: :create_customer

  get 'customers/:id', to: 'customers#show', as: :customer

  get 'customers/:id/edit', to: 'customers#edit', as: :edit_customer
  patch 'customers/:id', to: "customers#update", as: :update_customer

  delete 'customers/:id', to: "customers#destroy", as: :delete_customer

  #BOOKS
  get 'books', to: 'books#index', as: :books

  get 'books/new', to: 'books#new', as: :new_book
  post 'books', to: 'books#create', as: :create_book

  get 'books/:id', to: 'books#show', as: :book

  get 'books/:id/edit', to: 'books#edit', as: :edit_book
  patch 'books/:id', to: "books#update", as: :update_book

  delete 'books/:id', to: "books#destroy", as: :delete_book

  #LOANS
  get 'loans/customer_search', to: "loans#customer_search", as: :customer_search_form
  get 'loans/find_customer', to: "loans#find_customer", as: :find_customer
  get 'loans/book_search', to: "loans#book_search", as: :book_search_form
  get 'loans/find_books', to: "loans#find_book", as: :find_book

  get 'loans/new', to: 'loans#new', as: :new_loan
  post 'loans', to: 'loans#create', as: :create_loan

  get 'loans/book_search_for_returns', to: "loans#book_search_for_returns", as: :book_returns_search_form
  patch 'loans/finish', to: "loans#finish", as: :finish_loan

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
