module DbCleaner
  class << self
    def included(base)
      base.before do
        DatabaseCleaner.start
      end

      base.after do
        DatabaseCleaner.clean
      end
    end
  end
end
