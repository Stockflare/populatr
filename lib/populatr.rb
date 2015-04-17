require "populatr/version"

require 'aws-sdk'
require 'etcd'
require 'json'
require 'net/http'
require 'active_support/dependencies/autoload'

module Populatr

  extend ActiveSupport::Autoload

  autoload :Config
  autoload :Key
  autoload :Poller
  autoload :Request
  autoload :Response
  autoload :Populate

  eager_autoload do
    autoload :Config
  end


end
