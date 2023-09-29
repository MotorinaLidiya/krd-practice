FactoryBot.define do
  factory :comment, class: 'Post::Comment' do
    body { 'Some comment' }
    association :author, factory: :user
    association :post, factory: :post
  end
end
