require 'vi_gmail/message_header'

class Message < ActiveRecord::Base
  has_one :detail, class_name: 'MessageDetail', dependent: :destroy
  has_many :labels
  belongs_to :user
  belongs_to :thread, class_name: 'MessageThread', foreign_key: :thread_id

  STRF_MAP = { time: '%R', year: '%Y', month: '%b', date: '%d' }

  def printable_values
    [marker, formatted_date, truncated_from_address, subject_with_snippet, thread_id]
  end

  class << self
    def create_messages(thread, source_messages)
      source_messages.each do |source_message|
        message_header = ViGmail::MessageHeader.new(source_message.payload.headers)
        message = Message.new(message_header.attributes)
        message.attributes = { user_id: thread.user_id, source_id: source_message.id,
                               snippet: source_message.snippet, thread_id: thread.id }
        message.save!

        message.build_detail.create_record(message_header, source_message)

        Label.create_labels(message, source_message.label_ids)
      end
    end
  end

  private

  def marker
    labels.unread.exists? ? '+' : ' '
  end

  def truncated_from_address
    from.truncate(22).gsub(/\.\.$/, '').ljust(20, ' ')
  end

  def formatted_date
    date.strftime(time_or_year_component).rjust(12, ' ')
  end

  def time_or_year_component
    return STRF_MAP[:time] if date.today?

    time_or_year = current_year? ? STRF_MAP[:time] : STRF_MAP[:year]
    "#{ STRF_MAP[:month] } #{ STRF_MAP[:date] } #{ time_or_year }"
  end

  def current_year?
    date.year == Date.today.year
  end

  def subject_with_snippet
    [subject, snippet].join(' - ')
  end
end
