require 'json'

module Populatr
  class Poller

    attr_reader :queue

    def initialize(queue)
      @queue = queue
    end

    def poll(&block)
      sqs.poll { |message| block.call JSON.parse(message.body) }
    rescue => e
      raise "Error encountered whilst polling #{queue}: #{e.message}"
    end

    private

    def sqs
      @sqs ||= Aws::SQS::QueuePoller.new(queue)
    end

  end
end
