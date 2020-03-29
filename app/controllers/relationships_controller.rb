class RelationshipsController < ApplicationController
	def create
		@user = User.find(params[:follow_id])
		session_user.follow(@user)
		respond
	end

	def destroy
		@user = Relationship.find(params[:id]).follow
		session_user.unfollow(@user)
		respond
	end

	private
	def respond
		respond_to do |format|
			format.js { render locals: { user: @user } }
		end
	end
end
