class Lab < ApplicationRecord
	enum grade: %i[a b c d e fx f]

	belongs_to :user

	validate_enum_attribute :grade
	validates :description, length: { maximum: 500 }
	validates :title, length: { maximum: 250 }
end
