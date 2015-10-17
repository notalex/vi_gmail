require 'pathname'

module ViGmail
  module App
    extend self

    def home_config_dir
      return @home_config_dir if @home_config_dir
      home_path = ENV['HOME'] + '/.vi_gmail'
      Dir.mkdir(home_path) unless Dir.exists?(home_path)
      @home_config_dir = Pathname.new(home_path)
    end

    def root
      Pathname.new File.expand_path('../../../', __FILE__)
    end

    def db_config_folder_path
      home_config_dir.join('db')
    end

    def db_config_file_path
      db_config_folder_path.join('config.yml')
    end
  end
end
