FactoryGirl.define do
  factory :message_thread do
    association :user
    source_id { Forgery::Basic.number }
  end
end
