class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id # can store more info here.
      flash[:notice] = "Logged in sucessfully"
      redirect_to user
    else
      flash.now[:alert] = "There was something wrong with your login details."
      # needs now because there is no redirect
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out"
    redirect_to root_path
  end
end
