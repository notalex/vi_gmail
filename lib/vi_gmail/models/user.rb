class User < ActiveRecord::Base
  has_one :poll_history
  has_many :mail_threads
  has_many :messages
  has_many :labels
end
