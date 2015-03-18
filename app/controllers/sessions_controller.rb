class SessionsController < ApplicationController
	def new
		
	end

	def create 
		@user = User.find_by(email: session_params[:email])
		user.last_signed_in_at = Time.now

		if user && user.authenticate(session_params[:password])
			session[:user_id] = user.id
			redirect_to root_path, notice: 'Thanks'
		else
			redirect_to new_session_path, notice: 'Someone is wrong'
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to root_path, notice: 'See you'
	end

	private 

	def session_params
		params.require(:session).permit(:email, :password)
	end
end
