class User < ActiveRecord::Base
	devise 	:database_authenticatable, :registerable, :omniauthable,
			:recoverable, :rememberable, :trackable, :validatable

	attr_accessible :email, :password, :password_confirmation, :remember_me

	def self.find_for_open_id(access_token, signed_in_resource=nil)
		data = access_token.info
		if user = User.where(:email => data["email"]).first
			user
		else
			User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
		end
	end
end