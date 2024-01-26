FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' } # Replace with your desired default password
    # Add other attributes as needed
  end
end
