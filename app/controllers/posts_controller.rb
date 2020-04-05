class PostsController < ApplicationController
	before_action :login_user?, { only: [:show, :add, :search, :destroy] }

  def show
		@post = Post.find(params[:id])
		@comment = Comment.new
  end

  def add
		if request.post?
			@post = Post.new(post_params)
			@post.user_id = session[:user_id]
			if @post.save
				flash[:post_complete] = "写真を投稿しました"
				redirect_user_profile
			else
				render("add")
			end
		else
			@post = Post.new
		end
  end

	def search
		if request.post?
			if params[:keywords].empty?
				@posts = Post.all
			else
				split_keywords = params[:keywords].strip.split(/[[:blank:]]+/)
				@posts = []
				split_keywords.each do |keyword|
					@posts += Post.where("title like ? or message like ?", "%#{keyword}%", "%#{keyword}%")
				end
				@posts.uniq!
			end
		else
			@posts = Post.all
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		flash[:post_delete] = "投稿を削除しました"
		redirect_user_profile
	end

	private
	def post_params
		params.require(:post).permit(:image, :title, :message)
	end
end
