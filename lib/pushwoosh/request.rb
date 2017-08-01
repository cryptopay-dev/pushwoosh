require 'httparty'

module Pushwoosh
  class Request
    include HTTParty

    base_uri 'https://cp.pushwoosh.com/json/1.3/'
    format :json

    def self.make_post!(*args)
      new(*args).make_post!
    end

    def initialize(url, options = {})
      validations!(url, options)

      @options = options
      @notification_options = options.fetch(:notification_options)
      @url = url
      @base_request = {
        request: {
          application: options[:application],
          auth: options[:auth]
        }
      }
    end

    def make_post!
      response = self.class.post(url, body: build_request.to_json).parsed_response
      Response.new(response)
    end

    private

    attr_reader :options, :base_request, :notification_options, :url

    def validations!(url, options)
      raise Pushwoosh::Exceptions::Error, 'Missing application' unless options.fetch(:application)
      raise Pushwoosh::Exceptions::Error, 'Missing auth key' unless options.fetch(:auth)
      raise Pushwoosh::Exceptions::Error, 'URL is empty' if url.nil? || url.empty?
    end

    def build_request
      { request: full_request_with_notifications }
    end

    def full_request_with_notifications
      base_request[:request].merge(notifications: [notification_options])
    end
  end
end
