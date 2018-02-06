# frozen_string_literal: true

require 'maac/engine'
require 'maac/config'

module Maac
  class << self
    def configure
      yield config
    end

    def respond_to_missing?(symbol)
      config.respond_to?(symbol) || super
    end

    def method_missing(symbol, *args)
      if config.respond_to?(symbol)
        config.send(symbol, *args)
      else
        super
      end
    end

    private

    def config
      @config ||= Config.new
    end
  end
end
