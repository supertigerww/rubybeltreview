class UsersController < ApplicationController
  before_action :user_logged_in, only: [:new]
  before_action :user_authorized, only: [:edit]
  def new
  end

  def create
    user = User.create(user_params)

    if user.valid?
      session[:user_id] = user.id
      redirect_to "/events"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/"
    end
  end

  def edit
  end

  def editprocess
    current_user = current_user()
    user = User.find(current_user.id)

    user.update(user_params)

    if user.save
      redirect_to "/events"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/user/#{current_user.id}"
    end
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state ,:password,:password_confirmation )
    end
end
