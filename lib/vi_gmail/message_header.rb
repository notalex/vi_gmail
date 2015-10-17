module ViGmail
  class MessageHeader
    def initialize(headers)
      @headers = headers
    end

    def attributes
      data = %w(To From Subject Date).map do |field|
        [field.downcase, find_value(field)]
      end

      Hash[data]
    end

    private

    def find_value(name)
      @headers.find { |header| header.name == name }
              .value
    end
  end
end
