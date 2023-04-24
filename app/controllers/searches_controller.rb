class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search_list
    @range = params[:range]
    @search = params[:search]
    @word = params[:word]
    if @range == "Book"
      @books = Book.search_for(@search, @word)
    else
      @users = User.search_for(@search, @word)
    end
  end
end
