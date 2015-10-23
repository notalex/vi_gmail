FactoryGirl.define do
  factory :message_detail do
    to { Forgery::Internet.email_address }
    plain_body { Forgery::Email.body }
  end
end
