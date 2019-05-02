class UsersController < ApplicationController

	def show
		@user_precis = User.find(params[:id])
		@user_city_id = @user_precis.city_id
		@user_city = City.find(@user_city_id).name
	end

	def create
		@user = User.create(email: params[:email], password: params[:password], city_id: City.all.sample.id)
		log_in(@user)
		redirect_to root_path
	end


end