module ApplicationHelper
	def session_login(user)
		session[:user_id] = user.id
	end

	def session_user
		if session[:user_id]
			@user = User.find_by(id: session[:user_id])
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
		@user = nil
	end

	def login_user_invalid_operation_inspection(user)
		unless session_user?(user)
			invalid_operation
		end
	end
end
