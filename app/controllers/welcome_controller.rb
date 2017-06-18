class WelcomeController < ApplicationController
  def index
    @loans = Loan.all
    @books = Book.all
    @customers = Customer.all
  end
end
