class RankingController < ApplicationController
  def index
    @post_like_rank = rank_extraction(Post, Like, :post_id)
    @post_comment_rank = rank_extraction(Post, Comment, :post_id)
    @user_follower_rank = rank_extraction(User, Relationship, :follow_id)
    @user_post_rank = rank_extraction(User, Post, :user_id)
  end
  
  private
  def rank_extraction(output_model, target_model, column)
    output_model.find(target_model.group(column).order("count(#{column}) desc").limit(3).pluck(column))
  end
end