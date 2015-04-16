module Populatr
  class Response

    attr_reader :request

    def initialize(request)
      @request = request
    end

    def with_success!(body = {})
      send response(success, { Data: body })
    end

    def with_failed!(reason)
      send response(failed, { Reason: reason })
    end

    private

    def response(*merges)
      (merges + [request.verbatim_response]).reduce({}, :merge)
    end

    def success
      status("SUCCESS")
    end

    def failed
      status("FAILED")
    end

    def status(term)
      { Status: term }
    end

    def send(body = {})
      put = Net::HTTP::Put.new
      put.body = JSON.generate(body)
      http.request put
    end

    def http
      @http ||= Net::HTTP.new URI(request.response_url)
    end

  end
end
