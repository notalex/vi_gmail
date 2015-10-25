class User < ActiveRecord::Base
  has_one :poll_history, dependent: :destroy
  has_many :message_threads, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :labels, dependent: :destroy
end
