require 'thor'
require 'populatr'

module Populatr
  # Provides a Command Line Interface for Populatr. See the method definitions
  # for more information on its usage.
  #
  # @example Checking the version
  #   $ populatr version
  class CLI < Thor

    package_name "Populatr"

    class_option :host, type: :string, default: "127.0.0.1"

    class_option :port, type: :string, default: "4001"

    def initialize(*args)
      super
      Populatr.eager_load!
      Populatr::Config(options)
    end

    desc "version", "Displays the current version number of Populatr."
    # Displays the current version of the installed Populatr gem on the command line.
    # For more help on this command, use `populatr help version` from the command line.
    def version
      puts Populatr::VERSION
    end

    desc "start", "Start listening to the specified SQS Queue"
    method_option :listen, :type => :string, :desc => "SQS ARN"
    # Starts Populatr by binding it to a specific SQS Queue. This method blocks whilst
    # Populatr is running.
    def start
      poller = Poller.new(Config[:listen])
      poller.poll do |request|
        Populate.new(Request.new(request)).start!
      end
    end

  end
end
