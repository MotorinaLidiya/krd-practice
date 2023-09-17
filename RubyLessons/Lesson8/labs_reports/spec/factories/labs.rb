FactoryBot.define do
	factory :lab do
		title { 'Lab Title' }
		description { 'Lab Description' }
		association :user
	end
end
