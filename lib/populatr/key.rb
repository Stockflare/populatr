module Populatr
  class Key < Hash

    def key
      self["Key"]
    end

    def value
      self["Value"]
    end

    def ttl
      self["TTL"]
    end

    def properties
      hash = { value: value }
      hash[:ttl] = ttl.to_i if ttl
      hash
    end

    def to_args
      [key, properties]
    end

    def self.from_array(keys)
      keys.collect { |key| self.new.merge! key }
    end

  end
end
