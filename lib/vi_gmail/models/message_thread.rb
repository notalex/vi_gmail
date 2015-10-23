class MessageThread < ActiveRecord::Base
  has_many :messages, foreign_key: :thread_id
  belongs_to :user
end
