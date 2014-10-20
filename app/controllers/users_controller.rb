class UsersController < ApplicationController
  def create
    @user = User.new(new_user_params)
  end

  def new
    @user = User.new
  end

  private

  def new_user_params
    params.require(:user).permit(:email, :password)
  end
end
