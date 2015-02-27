class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  # Validates for plan signup form:
  validates :name, uniqueness: true, presence: true

  #validates :email, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :plan
  has_one :profile

  attr_accessor :stripe_card_token


  def save_with_payment
  	if valid?
  		customer = Stripe::Customer.create(description: email, plan: plan_id, card: stripe_card_token)
  		self.stripe_customer_token = customer.id
  		save!
  	end
  end
end
