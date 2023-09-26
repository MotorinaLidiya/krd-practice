FactoryBot.define do
  factory :image do
    association :imageable, factory: :post

    transient do
      photos_count { 3 }
    end

    after(:create) do |image, evaluator|
      evaluator.photos_count.times do
        image.photos.attach(io: File.open(Rails.root.join('spec', 'support', 'file.png')), filename: 'file.png', content_type: 'image/png')
      end
    end
  end
end
