class Message < ActiveRecord::Base
  has_one :detail, class_name: 'MessageDetail'
  has_many :labels
  belongs_to :user
  belongs_to :thread, class_name: 'MessageThread', foreign_key: :thread_id
end
