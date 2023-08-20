class Lab < ApplicationRecord
	belongs_to :user
	enum grade: %i[a b c d e fx f]
end
