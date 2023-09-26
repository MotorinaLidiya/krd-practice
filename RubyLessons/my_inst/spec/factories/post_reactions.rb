FactoryBot.define do
  factory :post_reaction do
    kind { :like }
    association :user, factory: :user
    association :post, factory: :post
  end
end
