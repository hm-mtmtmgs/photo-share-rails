class HomeController < ApplicationController
  def index
    @posts = Post.all.order("created_at desc").limit(12)
  end
end
