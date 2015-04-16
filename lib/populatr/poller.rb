require 'json'

module Populatr
  class Poller

    attr_reader :queue

    def initialize(queue)
      @queue = queue
    end

    def poll(&block)
      sqs.queues[queue].poll do |message|
        block.call JSON.parse(message.body)
      end
    rescue => e
      raise "Error encountered whilst polling #{queue}: #{e.message}"
    end

    private

    def sqs
      @sqs ||= AWS::SQS.new
    end

  end
end
