class Profile < ActiveRecord::Base
	validates :contact_email, uniqueness: true
	validates :avatar, :attachment_presence => true
	validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 2.megabytes
	belongs_to :user

	# Paperclip Configs:
	# We removed '/images/' for default location
	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "180x180>" }, :default_url => ":style/missing.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end