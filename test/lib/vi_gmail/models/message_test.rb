require 'test_helper'

describe Message do
  include DbCleaner

  describe 'formatted_date' do
    it 'must return time if it is today' do
      message = create(:message, date: 1.minute.ago)
      message_date = message.date
      formatted_date = message.send(:formatted_date)

      formatted_date.wont_match message_date.strftime('%b')
      formatted_date.must_match /\d\d:\d\d/
      formatted_date.wont_match message_date.year.to_s
    end

    it 'must return date with timestamp if it is in current year' do
      message = create(:message, date: Time.now.beginning_of_year)

      message_date = message.date
      formatted_date = message.send(:formatted_date)

      formatted_date.must_match message_date.strftime('%b')
      formatted_date.must_match message_date.day.to_s
      formatted_date.must_match /\d\d:\d\d/
      formatted_date.wont_match message_date.year.to_s
    end

    it 'must return date with year if it is not in current year' do
      message = create(:message, date: 1.year.ago)

      message_date = message.date
      formatted_date = message.send(:formatted_date)

      formatted_date.must_match message_date.strftime('%b')
      formatted_date.must_match message_date.day.to_s
      formatted_date.wont_match '\d\d:\d\d'
      formatted_date.must_match message_date.year.to_s
    end
  end

  describe 'marker' do
    it 'must return a plus sign for unread email' do
      message = create(:message)
      message.labels.create!(name: 'UNREAD')
      message.send(:marker).must_equal '+'
    end

    it 'must return a single spaced string for read email' do
      message = create(:message)
      message.send(:marker).must_equal ' '
    end
  end
end
