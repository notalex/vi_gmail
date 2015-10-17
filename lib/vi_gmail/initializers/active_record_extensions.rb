module ActiveRecordExtensions
  def encode(*fields)
    fields.each do |field|
      define_method "#{ field }=" do |text|
        return unless text
        options = { invalid: :replace, undef: :replace }
        value = text.encode('UTF-8', 'binary', options)
        write_attribute(field, value)
      end
    end
  end
end

ActiveRecord::Base.extend(ActiveRecordExtensions)
