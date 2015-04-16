module Populatr
  class Request

    attr_reader :body

    def initialize(body)
      @body = body
    end

    def type
      body["RequestType"].downcase.to_sym
    end

    def response_url
      body["ResponseURL"]
    end

    def properties
      body["ResourceProperties"]
    end

    def keys
      Key.from_array(properties["Keys"])
    end

    def verbatim_response
      keys = %w{StackId RequestId LogicalResourceId}
      body.keep_if { |key| keys.include? key.to_s }
    end

  end
end
