class User < ApplicationRecord
	has_many :labs, dependent: :destroy

	validates :first_name, :last_name, presence: true, length: { maximum: 100 }
	validates :email, presence: true, length: { maximum: 150 }, format: { with: URI::MailTo::EMAIL_REGEXP } 

	def full_name
		"#{first_name} #{last_name}"
	end
end
