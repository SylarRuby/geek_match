class ContactsController < ApplicationController
	def new
		@contact = Contact.new
		@contact_list = Contact.all
	end

	def create
		@contact = Contact.new(contact_params)

		if @contact.save
			# for sending the email
			name = params[:contact][:name]
			email = params[:contact][:email]
			body = params[:contact][:body]

			ContactMailer.contact_email(name, email, body).deliver
			flash[:success] = "Message sent!"
			redirect_to new_contact_path
		else
			flash[:error] = "Error, message not sent"
			redirect_to new_contact_path
		end
	end

	private

		def contact_params
			params.require(:contact).permit(:name, :email, :comments)
		end
end