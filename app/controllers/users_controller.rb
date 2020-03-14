class UsersController < ApplicationController
  def index
  end

  def show
  end

  def add
		@user = User.new
  end

  def edit
  end

	def login
		@user = User.new
	end
end
