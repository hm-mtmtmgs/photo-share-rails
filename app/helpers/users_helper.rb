module UsersHelper
	def user_liked_post(post_id)
		@post = Post.find(post_id)
	end
end
