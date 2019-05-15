class User < ApplicationRecord
	has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	after_create :welcome_send 
	has_many :attendances
	has_many :events, through: :attendances

	# On crée une méthode qui appele la méthode welcome_email de UserMailer,
	# on passe en paramètre la classe user.
	def welcome_send
		UserMailer.welcome_email(self).deliver_now
	end
end
