class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		@comment.user_id = session_user.id
		if @comment.save
			redirect_to("/posts/show/#{set_post.id}")
		else
			render template: "posts/show", collection: set_post
		end
	end

	def destroy
		@comment = Comment.find(params[:comment][:id])
		@comment.destroy
		redirect_to("/#{session_user.username}")
	end

	private
	def set_post
		@post = Post.find(params[:comment][:post_id])
	end

	def comment_params
		params.require(:comment).permit(:comment, :post_id)
	end
end
