class UsersController < ApplicationController
	before_action :login_user?, { only: [:show, :edit, :update, :logout, :search] }

  def show
		@user = User.find_by(username: params[:username])
  end

  def add
		if request.post?
			@user = User.new(user_params)
			@user.username = SecureRandom.hex(4)
			if @user.save
				flash[:regist] = "ユーザー登録が完了しました。ログインして写真を投稿しよう"
				redirect_to("/login")
			else
				render("add")
			end
		else
			@user = User.new
		end
  end

  def edit
		@user = User.find_by(username: params[:username])
		unless session_user?(@user)
			invalid_operation
		end
  end

	def update
		@user = User.find(session[:user_id])
		if @user.update(user_params)
			flash[:edit] = "プロフィールを更新しました"
			redirect_to("/#{@user.username}")
		else
			render("edit")
		end
	end

	def login
		if request.post?
			@user = User.find_by(email: params[:email])
			if @user && @user.authenticate(params[:password])
				session_login(@user)
				flash[:login] = "ログインしました"
				redirect_to("/#{@user.username}")
			else
				if @user.nil?
					@user = User.new(email: params[:email])
				end
				@error = "メールアドレスまたはパスワードが間違っています"
				render("login")
			end
		else
			@user = User.new
		end
	end

	def logout
		session_logout
		redirect_to("/")
	end

	def search
		if request.post?
			if params[:keywords].empty?
				@users = User.all
			else
				split_keywords = params[:keywords].strip.split(/[[:blank:]]+/)
				@users = []
				split_keywords.each do |keyword|
					@users += User.where("name like ? or username like ?", "%#{keyword}%", "%#{keyword}%")
				end
				@users.uniq!
			end
		else
			@users = User.all
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :username, :birthday, :introduction)
	end
end
