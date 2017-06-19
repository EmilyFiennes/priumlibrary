class LoansController < ApplicationController

  def customer_search
    set_customer
  end

  def find_customer
    @customer = Customer.find_by("email = ?", params[:customer][:email])
    if !!@customer
      redirect_to book_search_form_path(customer_id: @customer.id)
    else
      flash[:alert] = "Unable to find customer. Please try again"
      set_customer
      render :customer_search
    end
  end

  def book_search
    @customer = Customer.find(params[:customer_id])
    set_book
  end

  def find_book
    @customer = Customer.find(params[:book][:customer_id])
    @book = Book.find_by(title: params[:book][:title])
    if !!@book
      redirect_to new_loan_path(customer_id: @customer.id, book_id: @book.id)
    else
      flash[:alert] = "Unable to find book. Please try again"
      set_book
      render :book_search
    end
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @book = Book.find(params[:book_id])
    @loan = Loan.new(customer: @customer, book: @book)
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.save(loan_params)
      flash[:success] = "New loan created with success"
      redirect_to book_search_form_path(customer_id: @loan.customer.id)
    else
      flash[:alert] = @loan.errors.full_messages.join(", ")
      render :new
    end
  end

  def book_search_for_returns
    @book = Book.new
  end

  def finish
    @book = Book.on_loan.find_by(title: params[:book][:title])
    if !!@book && @book.may_finish_loan?
      @book.finish_loan!
      flash[:success] = "Book successfully returned."
      redirect_to book_returns_search_form_path
    else
      set_book
      flash[:alert] = "Unable to return book. Please check that the book has not already been returned."
      render :book_search_for_returns
    end
  end

  private

  def loan_params
    params.require(:loan).permit(:customer_id, :book_id)
  end

  def set_customer
    @customer = Customer.new
  end

  def set_book
    @book = Book.new
  end
end
