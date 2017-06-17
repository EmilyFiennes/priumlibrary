class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.order(:title).page params[:page]
    # @books = Book.all.take(3)
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save(book_params)
      redirect_to book_path(@book)
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = "#{@book.title} by #{@book.author} has successfully been deleted from the system"
      redirect_to books_path
    else
      flash[:error] = Unable to delete user
    end
  end


  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :summary)
  end
end


