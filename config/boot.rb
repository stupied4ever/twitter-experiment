ENV['ENVIRONMENT'] ||= 'development'

require 'bundler'

Bundler.require :default, ENV['ENVIRONMENT']
Mongoid.load! 'config/mongoid.yml', ENV['ENVIRONMENT']

if ENV['ENVIRONMENT'].in? ['development', 'test']
  require 'dotenv'
  Dotenv.load!
end
require_relative '../app/models/tweet'
require_relative '../app/streams/forest'
