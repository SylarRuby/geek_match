class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
	end

	def show
		@user = User.friendly.find( params[:id] )
		@pro_plan = Plan.find(2)
		@basic_plan = Plan.find(1)
	end


end

