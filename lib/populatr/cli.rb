require 'ambassadr'
require 'populatr'

module Populatr
  # Provides a Command Line Interface for Populatr.
  # @todo Describe Usage
  class CLI

    DEFAULT_PATH = '/properties/shared'

    attr_reader :argv, :path

    attr_accessor :key, :value

    def initialize(argv = [])
      @argv = argv.dup
      configure_key!
      configure_value!
      configure_path!
    end

    def run
      if Ambassadr::Properties.new(path).set(key, value)
        "OK: #{key} => #{value}"
      else
        raise "unable to set (#{path}) #{key} => #{value}"
      end
    end

    def configure_key!
      key = argv.index("-key")
      raise 'no key has been set' unless key
      argv.delete_at key
      self.key = argv.delete_at(key)
    rescue => e
      puts e
    end

    def configure_value!
      value = argv.index("-value")
      raise 'no value has been set' unless value
      argv.delete_at value
      self.value = argv.delete_at(value)
    rescue => e
      puts e
    end

    def configure_path!
      path = argv.index("-path")
      raise nil unless path
      argv.delete_at path
      @path = argv.delete_at(path)
    rescue => e
      puts e
    end

  end
end
