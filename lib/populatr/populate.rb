module Populatr
  class Populate

    attr_reader :request, :keys, :respond

    def initialize(request)
      @response = Response.new request
      @request = request
      @keys = @request.keys
    end

    def start!
      if respond_to? request.type
        send request.type
      else
        respond.with_failed! "Request type #{request.type} not supported"
      end
    end

    def create
      keys.each { |key| etcd.set *key.to_args }
      respond.with_success!
    rescue => e
      respond.with_failed! e.message
    end

    alias_method :update, :create

    def delete
      keys.each { |key| etcd.delete key.key }
      respond.with_success!
    rescue => e
      respond.with_failed! e.message
    end

    private

    def etcd
      @etcd ||= Etcd.client Config.select(:host, :port)
    end

  end
end
