require 'rubygems'
require 'bundler/setup'

require 'active_support'

ActiveSupport::Dependencies.autoload_paths += %w[
  lib/
]
