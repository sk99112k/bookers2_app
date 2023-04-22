class SearchesController < ApplicationController

  def search
    @range = params[:range]
    if @range == "Book"
      @book = Book.looks(params[:search],params[:word])
    else
      @user = User.looks(params[:search],params[:word])
    end
  end

end
