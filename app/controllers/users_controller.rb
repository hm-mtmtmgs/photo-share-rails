class UsersController < ApplicationController
	before_action :login_user?, { only: [:show, :edit, :update, :logout, :search, :following, :follower, :setting] }

  def show
		user_get_from_username
		@post = Post.all
  end

  def create
		if request.post?
			@user = User.new(user_params)
			@user.username = SecureRandom.hex(4)
			if @user.save
				flash[:regist] = "ユーザー登録が完了しました。ログインして写真を投稿しよう"
				render("login")
			else
				render("create")
			end
		else
			@user = User.new
		end
  end

  def edit
		user_get_from_username
		login_user_invalid_operation_inspection(@user)
  end

	def update
		user_get_from_username
		if @user.update(user_params)
			flash[:profile_edit] = "プロフィールを更新しました"
			redirect_user_profile
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
				redirect_user_profile
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
		redirect_home
	end

	def search
		if request.post?
			if params[:keywords].empty?
				@users = User.all
			else
				split_keywords = params[:keywords].strip.split(/[[:blank:]]+/)
				@users = []
				split_keywords.each do |keyword|
					@users += User.where("name like ? or username like ? or introduction like ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
				end
				@users.uniq!
			end
		else
			@users = User.all
		end
	end

	def following
		user_get_from_username
	end

	def follower
		user_get_from_username
	end
	
	def setting
		user_get_from_username
		login_user_invalid_operation_inspection(@user)
		if request.patch?
			logger.debug @user.errors.inspect
			if params[:user][:email]
				if @user.update(user_params)
					flash[:email_edit] = "メールアドレスを更新しました"
					redirect_user_profile
				end
			elsif params[:user][:current_password]
				unless @user.authenticate(params[:user][:current_password])  
					@user.errors.add(:base, "現在のパスワードを正しく入力してください")
				else
					if @user.update(user_params)
						flash[:password_edit] = "パスワードを更新しました"
						redirect_user_profile
					end
				end
			end
		elsif request.delete?
			session_user.destroy
			session_logout
			redirect_home
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :username, :birthday, :introduction)
	end

	def user_get_from_username
		@user = User.find_by(username: params[:username])
	end
end
