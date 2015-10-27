FactoryGirl.define do
  factory :message do
    association :user
    association :thread, factory: :message_thread
    source_id { Forgery::Basic.number }
    from { Forgery::Internet.email_address }
    subject { Forgery::Email.subject }
    snippet { Forgery::Email.subject }
    date { Forgery::Date.date(past: true) }
  end
end
