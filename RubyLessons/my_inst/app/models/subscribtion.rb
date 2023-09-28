class Subscribtion < ApplicationRecord
	belongs_to :owner, class_name: 'User'
	belongs_to :subscriber, class_name: 'User'

  validates :subscriber, uniqueness: { scope: :owner }
end
