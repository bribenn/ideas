class UsersController < ApplicationController
	before_action :require_login, except: [:create, :new]
	def new
		#renders register/login page
	end

	def create
  	user = User.create(user_params)
	  	if user.valid?
	  		session[:user_id] = user.id
	  		redirect_to '/bright_ideas'
	  	else
	  		flash[:registration_errors] = user.errors.full_messages
	  		redirect_to '/main'
	  	end
  	end

  	def show
  		@user = User.find(params[:user_id])
  	end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :alias, :password, :password_confirmation)
  end


end
