class PollHistory < ActiveRecord::Base
  belongs_to :user

  class << self
    def save_history_id(user, history_id)
      poll_history = where(user: user).first_or_initialize
      poll_history.last_fetched_id = history_id
      poll_history.save!
    end
  end
end
