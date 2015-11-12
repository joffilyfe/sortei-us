CONSUMER_TOKEN = ENV['TWITTER_CONSUMER_KEY']
CONSUMER_TOKEN_SECRET = ENV['TWITTER_CONSUMER_KEY_SECRET']

module TwitterOauth
  module Prepare
    def self.consumer
      return OAuth::Consumer.new(CONSUMER_TOKEN, CONSUMER_TOKEN_SECRET, { :site => "https://api.twitter.com", :scheme => :header })
    end

    def self.autorize_url(consumer)
      @request_token = consumer.get_request_token :oauth_callback => @callback_url
      return @request_token.authorize_url
    end

    def self.token
      return @request_token.token
    end

    def self.secret
      return @request_token.secret
    end

    def self.mount_url(base_url)
      @callback_url = "#{base_url}/auth/confirm"
    end

  end

  module Confirm
    def self.access_token(request_token, request_token_secret, oauth_verifier)
      request_token = OAuth::RequestToken.new Prepare.consumer, request_token, request_token_secret
      access_token = request_token.get_access_token :oauth_verifier => oauth_verifier
      return access_token
    end
  end
end

