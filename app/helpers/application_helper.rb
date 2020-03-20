module ApplicationHelper
	def session_login(user)
		session[:user_id] = user.id
	end

	def session_user
		if session[:user_id]
			@current_user = User.find_by(id: session[:user_id])
		end
	end

	def session_user?(user)
		user == session_user
	end

	def session_now?
		!session_user.nil?
	end

	def session_logout
		session.delete(:user_id)
		@current_user = nil
	end
end
