class SessionsController < ApplicationController
	protect_from_forgery
	include SessionsHelper
	# Force signout to prevent CSRF attacks
	def handle_unverified_request
		sign_out
		super
	end

	def new
		render 'new'
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#signed in and redirect to welcome page
			sign_in user
			redirect_back_or user
		else
			#failure send error messages
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end


end
