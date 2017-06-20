class SessionsController < ApplicationController
  before_action :require_login, except: [:create]

  def create
  	user = User.find_by(email: login_params[:email])
  	if user && user.authenticate(login_params[:password])
  		session[:user_id] = user.id
  		redirect_to '/bright_ideas'
  	else 
  		flash[:login_error] = 'invalid credentials'
  		redirect_to '/main'
  	end
  end

  def destroy
  	reset_session
  	redirect_to '/main'
  end

  private
  def login_params
  	params.require(:login).permit(:email, :password)
  end
end
