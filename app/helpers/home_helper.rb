module HomeHelper
	def home_new_arrival_post
		@posts = Post.all.order("created_at desc").limit(10)
	end
end
