module PostsHelper
	def	user_other_post
		@post.user.post.where("id <> ?", @post.id)
	end
	
	def user_new_arrival_other_post
		@post.user.post.where("id <> ?", @post.id).order("created_at desc").limit(5)
	end
end
