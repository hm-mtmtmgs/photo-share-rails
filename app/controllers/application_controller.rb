class ApplicationController < ActionController::Base
	include(ApplicationHelper)

	private
	def login_user?
		unless session_now?
			invalid_operation
		end
	end

	def invalid_operation
		@invalid_message = "不正な操作が行われました"
		render template: "home/index"
	end
end
