require 'googleauth'
require 'google/api_client/client_secrets'
require 'google/api_client/auth/installed_app'
require 'google/api_client/auth/storage'
require 'google/api_client/auth/storages/file_store'
require 'fileutils'

module ViGmail
  class GoogleClient
    APPLICATION_NAME = 'ViGmail'
    CLIENT_SECRETS_PATH = 'client_secret.json'
    SCOPE = 'https://www.googleapis.com/auth/gmail.readonly'

    def authorize
      current_valid_oauth || new_oauth
    end

    private

    def current_valid_oauth
      valid_oauth?(current_oauth) && current_oauth
    end

    def current_oauth
      @current_oauth ||= stored_oauth_credentials.authorize
    end

    def valid_oauth?(oauth)
      oauth && (!oauth.expired? || oauth.refresh_token)
    end

    def stored_oauth_credentials
      return @storage if @storage
      file_store = Google::APIClient::FileStore.new(oauth_credentials_path)
      @storage = Google::APIClient::Storage.new(file_store)
    end

    def new_oauth
      FileUtils.mkdir_p(File.dirname(oauth_credentials_path))

      google_api_flow.authorize(stored_oauth_credentials, {})
    end

    def google_api_flow
      app_info = Google::APIClient::ClientSecrets.load(CLIENT_SECRETS_PATH)

      Google::APIClient::InstalledAppFlow.new({
        client_id: app_info.client_id,
        client_secret: app_info.client_secret,
        scope: SCOPE
      })
    end

    def oauth_credentials_path
      App.home_config_dir.join('.credentials/oauth.json')
    end
  end
end
