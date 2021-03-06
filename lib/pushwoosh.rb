require 'pushwoosh/version'
require 'pushwoosh/push_notification'
require 'pushwoosh/configurable'

module Pushwoosh
  extend Pushwoosh::Configurable

  class << self
    def notify_all(message, notification_options = {})
      PushNotification.new(options).notify_all(message, notification_options)
    end

    def notify_devices(message, devices = [], notification_options = {})
      PushNotification.new(options).notify_devices(message, devices, notification_options)
    end
  end
end
