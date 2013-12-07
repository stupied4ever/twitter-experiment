ENV['ENVIRONMENT'] ||= 'development'

require 'bundler'

Bundler.require :default, ENV['ENVIRONMENT']
Mongoid.load! 'config/mongoid.yml', ENV['ENVIRONMENT']

require_relative 'twitter'

require_relative '../app/streams/executer'