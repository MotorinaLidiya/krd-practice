FactoryBot.define do
  factory :post_reaction, class: 'Post::Reaction' do
    kind { :like }
    association :user, factory: :user
    association :post, factory: :post
  end
end
