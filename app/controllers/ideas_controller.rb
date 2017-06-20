class IdeasController < ApplicationController
	before_action :require_login
	
	def index
		# @ideas = Idea.all.includes(:user, :likes)
		@ideas = Idea.all.joins("left join likes on ideas.id = likes.idea_id").select("ideas.*, count(likes.id) AS likes_count").group('ideas.id').order("likes_count DESC")
		# @ideas = Idea.all.joins(:likes).select("ideas.* count(likes.id) AS likes_count").order("likes_count DESC")
		@ideas_liked = current_user.ideas_liked_ids
		@current_user = User.find(session[:user_id])
	end

	def create
		idea = Idea.create(idea_params.merge(user: current_user))
	  	if idea.valid?
	  		redirect_to "/bright_ideas"
	  	else
	  		flash[:idea_errors] = idea.errors.full_messages
	  		redirect_to "/bright_ideas"
	  	end
  	end

  	def show
  		@idea = Idea.find(params[:idea_id])
  		@users = User.all
  		@users_liked = @idea.users_liked_ids
  	end

  	def destroy
  		idea = Idea.find(params[:idea_id]).destroy
  	redirect_to '/bright_ideas'
  	end

	private
	  def idea_params
	  	params.require(:idea).permit(:content)
	  end

end
