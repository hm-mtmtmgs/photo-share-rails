class UsersController < ApplicationController
  def show
  end

  def add
		if request.post? then
			@user = User.new(user_params)
			if @user.save then
				flash[:notice] = "ユーザー登録が完了しました。ログインして写真を投稿しよう"
				redirect_to("/login")
			else
				render("add")
			end
		else
			@user = User.new
		end
  end

  def edit
  end

	def login
		if request.post? then
			@user = User.find_by(email: params[:email], password: params[:password])
			if @user
				flash[:notice] = "ログインしました"
				redirect_to("/")
			else
				@user = User.new
				@error = "メールアドレスまたはパスワードが間違っています"
				render("login")
			end
		else
			@user = User.new
		end
	end

	def search
		@users = User.all
	end

	private
	def user_params
		params.require(:user).permit(:name, :password, :icon, :email, :birthday)
	end

end
