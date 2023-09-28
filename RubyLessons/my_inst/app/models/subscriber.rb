class Subscriber < ApplicationRecord
	belongs_to :owner, class_name: 'User'
	belongs_to :subscriber, class_name: 'User'
end
