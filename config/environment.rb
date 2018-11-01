require 'rubygems'
require 'bundler/setup'

require 'active_support'
require 'state_machine'

ActiveSupport::Dependencies.autoload_paths += %w[
  lib/
]
