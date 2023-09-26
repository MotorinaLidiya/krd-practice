FactoryBot.define do
  factory :post do
    title { 'Post Title' }
    association :author, factory: :user

    trait :with_image do
      after(:build) do |post|
        post.image = create(:image)
      end
    end 
  end
end
