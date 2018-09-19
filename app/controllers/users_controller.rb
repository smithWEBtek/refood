class UsersController < ApplicationController
  layout "application_no_login_link", only: [:new]
  before_action :require_login, except: [:new, :create]
  before_action :redirect_to_index_if_logged_in, only: [:new, :create]

  def index
  end
    
  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.build_giver
      user.build_receiver
      user.save

      session[:user_id] = user.id
      redirect_to '/index'
    else
      flash[:error] = user.errors.full_messages.uniq
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end 

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:message] = "Profile successfully updated"
      redirect_to '/index'
    else
      flash[:error] = @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :username, :address, :address2, :city, :state, :zip_code, :phone, :password, :password_confirmation)
  end
end
