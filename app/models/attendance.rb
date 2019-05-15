class Attendance < ApplicationRecord
	after_create :welcome_event
	belongs_to :user
	belongs_to :event

	# Méthode qui appelle la méthode event_welcome_email de UserMailer,
	# on lui passe en paramètre l'instance d'event que l'on retrouve grâce à son id.
	def welcome_event
		UserMailer.event_welcome_email(self.event, self.user).deliver_now
	end
end
