FactoryGirl.define do
  factory :user do
    email { Forgery::Internet.email_address }
    name { Forgery::Name.full_name }
  end
end
