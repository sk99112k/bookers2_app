class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book)
  end

  def index
    @book = Book.new
    @books = Book.all

  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @books = Book.all
  end

  private
  def book_params
    params.permit(:title,:body)
  end
end
