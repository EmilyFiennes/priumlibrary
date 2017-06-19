class LoansController < ApplicationController
  def customer_search
    @customer = Customer.new
  end

  def find_customer
    @customer = Customer.where("email = ?", params[:customer][:email]).first
    if !!@customer
      redirect_to controller: 'loans', action: 'book_search', customer_id: @customer.id
    else
      flash[:alert] = "Unable to find customer. Please try again"
      @customer = Customer.new
      render :customer_search
    end
  end


  def book_search
    @customer = Customer.find_by(id: params[:customer_id])
    @book = Book.new
  end

  def find_book
    @customer = Customer.find_by(id: params[:book][:customer_id])
    @book = Book.where("title = ?", params[:book][:title]).first
    if !!@book
      redirect_to controller: 'loans', action: 'new', customer_id: @customer.id, book_id: @book.id
    else
      flash[:alert] = "Unable to find book. Please try again"
      @book = Book.new
      render :book_search
    end
  end

  def new
    @loan = Loan.new(customer_id: params[:customer_id], book_id: params[:book_id])
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.book.may_start_loan?
      @loan.book.start_loan
      @loan.book.save!
      if @loan.save(loan_params)
        flash[:alert] = "New loan created with success"
        redirect_to controller: 'loans', action: 'book_search', customer_id: params[:loan][:customer_id], book_id: params[:loan][:book_id]
      end
    else
      flash[:alert] = "Unable to create loan"
      render :new
    end
  end

  def book_search_for_returns
    @book = Book.new
  end

  def end_loan
    @book = Book.where("title = ?", params[:book][:title]).first
    @book.set_loan_return_time!
    @book.finish_loan if @book.may_finish_loan?
    if @book.save!
      flash[:alert] = "Book successfully returned."
      redirect_to controller: 'loans', action: 'book_search_for_returns'
    else
      flash[:alert] = "Unable to return book. Please check that the book has not already been returned."
      render :book_search_for_returns
    end
  end


  private

  def loan_params
    params.require(:loan).permit(:customer_id, :book_id, :finished_at)
  end
end
