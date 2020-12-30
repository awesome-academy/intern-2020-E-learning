FactoryBot.define do
  factory :comment do
    user
    content {Faker::Lorem.words(number: 12).join(" ")}
  end
end
