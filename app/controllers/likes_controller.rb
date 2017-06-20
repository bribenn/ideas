class LikesController < ApplicationController
	before_action :require_login 
  def create
  	like = Like.create(user: current_user, idea: Idea.find(params[:idea_id]))
  	redirect_to '/bright_ideas'
  end

  def destroy
  	like = Like.find_by(user: current_user, idea: Idea.find(params[:idea_id])).destroy
  	redirect_to '/bright_ideas'
  end
end
