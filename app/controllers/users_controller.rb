class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @days_2ago_books = @books.created_days_2ago
    @days_3ago_books = @books.created_days_3ago
    @days_4ago_books = @books.created_days_4ago
    @days_5ago_books = @books.created_days_5ago
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), notice: "guestuserはプロフィール編集画面へ遷移できません。"
    end
  end

end
