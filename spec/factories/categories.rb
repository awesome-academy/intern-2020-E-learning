FactoryBot.define do
  factory :category do
    name {Faker::Name.unique.name}
    description {Faker::Lorem.words(number: 12)}
  end
end
