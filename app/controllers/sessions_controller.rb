class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by_email(user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      session[:name] = user.name
      session[:email] = user.email
      redirect_to chat_path
    else
      flash[:error] = 'Invalid Email or Password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:email] = nil
    session[:name] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
