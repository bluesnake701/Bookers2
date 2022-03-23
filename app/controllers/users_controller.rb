class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @newbook = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      @users = User.all
      render :edit
    end
    flash[:success] = 'You have updated user successfully.'
  end

  def index
    @user = current_user
    @users = User.all
    @newbook = Book.new
  end

   private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
  end
end
