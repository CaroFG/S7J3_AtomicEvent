class Event < ApplicationRecord

	has_one_attached :picture
	has_many :attendances
	has_many :users, through: :attendances
	belongs_to :admin, class_name: "User"

	# --------------- Validates des events ------------------
	validates :start_date, presence: true
	validate :cannot_change_the_past

	validates :duration, presence: true
	validate :multiple_of_5	

	validates :title, presence: true, length: { in: 5..140 }

	validates :description, presence: true, length: { in: 20..1000}

	validates :price, presence: true, numericality: { greather_than_or_equal_to: 0, less_than_or_equal_to: 1000 }

	validates :location, presence: true
	validate :has_picture

# Methode pour verifier la startdate de l'event,
# impossible de creer ou modifier un event passe.
def cannot_change_the_past
	if start_date.present? && start_date < Date.today
		errors.add(:start_date, "You can't change the past")
	end
end

# Methode pour verifier le format de la duree de l'event,
# impossible de creer sans que ce soit un multiple de 5.
def multiple_of_5

	if duration == 0 || duration % 5 != 0
		errors.add(:duration, "it must be a multiple of 5")
	end

end

# Méthode pour calculer la end_date de l'event.
def end_date
	start_date + duration * 60
end

def is_coming?(user)

	if self.attendances.where(user_id: user.id).count > 0
		return true
	else
		return false
	end
end

def has_picture
	if self.picture.attached? == false
		errors.add(:picture, "You must upload a picture")
	end
end


end
