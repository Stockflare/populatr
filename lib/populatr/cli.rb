require 'ambassadr'
require 'populatr'

module Populatr
  # Provides a Command Line Interface for Populatr.
  # @todo Describe Usage
  class CLI

    DEFAULT_PATH = '/properties/shared'

    attr_reader :argv

    attr_accessor :key, :value

    def initialize(argv = [])
      @argv = argv.dup
      configure_key!
      configure_value!
      set_key!
    end

    def set_key!
      Ambassadr::Properties.new(path).set(key, value)
    end

    def configure_key!
      key = argv.index("-key")
      raise 'no key has been set' unless key
      argv.delete_at key
      self.key = key
    rescue => e
      puts e
    end

    def configure_value!
      value = argv.index("-value")
      raise 'no value has been set' unless value
      argv.delete_at value
      self.value = value
    rescue => e
      puts e
    end

    private

    def path
      path = argv.index("-path")
      if path
        path
      else
        ENV['PROPERTIES_PATH'] || DEFAULT_PATH
      end
    end

  end
end
