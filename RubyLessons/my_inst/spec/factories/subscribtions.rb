FactoryBot.define do
  factory :subscribtion do
    owner { association(:user) }
    subscriber { association(:user) }
  end
end
