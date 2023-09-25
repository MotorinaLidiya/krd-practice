FactoryBot.define do
  factory :post do
    title { 'Post Title' }
    association :user
  end
end
