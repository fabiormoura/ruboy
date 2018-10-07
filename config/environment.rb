# ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'rubygems'
require 'bundler/setup'

require 'active_support'

ActiveSupport::Dependencies.autoload_paths += %w[
  lib/
]
