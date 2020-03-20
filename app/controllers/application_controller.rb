class ApplicationController < ActionController::Base
	include(ApplicationHelper)

	private
	def login_user?
		unless session_now?
			redirect_to("/")
		end
	end
end
