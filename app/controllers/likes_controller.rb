class LikesController < ApplicationController
	before_action :set_post

	def create
		@like = Like.new(user_id: session_user.id, post_id: @post.id)
		@like.save
		respond
	end

	def destroy
		@like = Like.find_by(user_id: session_user.id, post_id: @post.id)
		@like.destroy
		respond
	end

	private
	def set_post
		@post = Post.find(params[:post_id])
	end

	def respond
		respond_to do |format|
			format.js { render locals: { post: @post } }
		end
	end
end
