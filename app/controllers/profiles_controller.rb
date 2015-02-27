class ProfilesController < ApplicationController
	# Search Google for before filters
	before_action :authenticate_user!
	before_action :only_current_user
	
	def new
		# form where a user can fill out their OWN profile
		@user = User.friendly.find( params[:user_id] )
		@profile = Profile.new
	end

	def create
		@user = User.friendly.find( params[:user_id] )
		@profile = @user.build_profile(profile_params)
		if @profile.save
			flash[:success] = 'Profile Created!'
			# redirects to users/show.html.erb
			redirect_to user_path( params[:user_id] )
		else
			# search 'rails rendering layouts' on google:
			render action: :new
		end
	end

	def edit
		@user = User.friendly.find( params[:user_id] )
		@profile = @user.profile
	end

	def update
		@user = User.friendly.find( params[:user_id] )
		@profile = @user.profile
		if @profile.update_attributes(profile_params)
			flash[:success] = 'Profile Updated!'
			# redirects to users/show.html.erb
			redirect_to user_path( params[:user_id] )
		else
			render action: :edit
		end
	end

	# To protect what's coming into our database ie: from forms to database
	private
		def profile_params
			params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
		end

		def only_current_user
			@user = User.friendly.find( params[:user_id] )
			redirect_to(root_url) unless @user == current_user
		end

end