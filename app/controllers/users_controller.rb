class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_books = @books.created_today
    @yesterday_books = @books.created_yesterday
    @this_week_books = @books.created_this_week
    @last_week_books = @books.created_last_week
    @graph_data = {
  	  "6日前" => @books.created_6day_ago.count,
  	  "5日前" => @books.created_5day_ago.count,
  	  "4日前" => @books.created_4day_ago.count,
  	  "3日前" => @books.created_3day_ago.count,
  	  "2日前" => @books.created_2day_ago.count,
  	  "昨日" => @books.created_yesterday.count,
  	  "今日" => @books.created_today.count
    }
    if params[:created_at].present?
      # present、存在の有無
      @create_at_books = @books.where(created_at: params[:created_at].in_time_zone.all_day)
    else
      @create_at_books = nil
    end
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
