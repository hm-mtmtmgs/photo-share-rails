module PostsHelper
	def user_new_arrival_post
		@post.user.post.where("id <> ?", @post.id).order("created_at desc").limit(5)
	end
end
