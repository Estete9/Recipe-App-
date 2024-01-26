FactoryBot.define do
  factory :inventory do
    name { Faker::Lorem.word }
    # Add other attributes as needed
  end
end
