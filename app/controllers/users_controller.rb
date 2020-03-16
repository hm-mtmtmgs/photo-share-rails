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
		if request.post? then
			if params[:keywords].empty?
				@users = User.all
			else
				split_keywords = params[:keywords].strip.split(/[[:blank:]]+/)
				@users = []
				split_keywords.each do |keyword|
					@users += User.where("name like ? or email like ?", "%#{keyword}%", "%#{keyword}%")
				end
				@users.uniq!
			end
		else
			@users = User.all
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :password, :icon, :email, :birthday)
	end

end
