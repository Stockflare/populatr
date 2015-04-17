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

    def uri
      @uri ||= URI(request.response_url)
    end

    def put
      @put ||= Net::HTTP::Put.new uri
    end

    private

    def response(*merges)
      (merges + [request.verbatim_response.clone]).reduce({}, :merge)
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
      # put.body = JSON.generate(body)
      # # put = Net::HTTP::Put.new
      # # put.body = JSON.generate(body)
      # Net::HTTP.request put
      # # http.request
      Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(put)
      end
    end

  end
end
