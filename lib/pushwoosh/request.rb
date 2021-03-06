require 'net/http'
require 'json'

module Pushwoosh
  class Request
    def self.make_post!(*args)
      new(*args).make_post!
    end

    def initialize(url, options = {})
      validations!(url, options)

      base_uri = 'https://cp.pushwoosh.com/json/1.3'
      @options = options
      @notification_options = options.fetch(:notification_options)
      @url = [base_uri, url].join
      @base_request = {
        request: {
          application: options[:application],
          auth: options[:auth]
        }
      }
    end

    def make_post!
      uri = URI(url)
      response = http(uri).request(request(uri, build_request.to_json))
      Response.new(JSON.parse(response.body))
    end

    private

    attr_reader :options, :base_request, :notification_options, :url

    def validations!(url, options)
      raise Pushwoosh::Exceptions::Error, 'Missing application' unless options.fetch(:application)
      raise Pushwoosh::Exceptions::Error, 'Missing auth key' unless options.fetch(:auth)
      raise Pushwoosh::Exceptions::Error, 'URL is empty' if url.nil? || url.empty?
    end

    def request(uri, body)
      req = Net::HTTP::Post.new(uri.request_uri, 'Content-Type' => 'application/json')
      req.body = body
      req
    end

    def http(uri)
      client = Net::HTTP.new(uri.host, uri.port)
      client.use_ssl = true
      client.verify_mode = OpenSSL::SSL::VERIFY_NONE
      client
    end

    def build_request
      { request: full_request_with_notifications }
    end

    def full_request_with_notifications
      base_request[:request].merge(notifications: [notification_options])
    end
  end
end
