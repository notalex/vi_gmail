FactoryGirl.define do
  factory :label do
    name %w(INBOX SENT IMPORTANT UNREAD).sample
  end
end
