class PostsController < ApplicationController
	before_action :login_user?, { only: [:show, :add, :search] }

  def show
  end

  def add
		if request.post?
			@post = Post.new(post_params)
			@post.user_id = session[:user_id]
			if @post.save
				flash[:post_complete] = "写真を投稿しました"
				redirect_to("/#{session_user.username}")
			else
				render("add")
			end
		else
			@post = Post.new
		end
  end

  def edit
  end

	def search
		@posts = Post.all
	end

	private
	def post_params
		params.require(:post).permit(:image, :title, :message)
	end
end
