class MessageDetail < ActiveRecord::Base
  encode :plain_body

  belongs_to :message
end
