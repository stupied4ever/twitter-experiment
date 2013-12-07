require_relative 'boot'

include Clockwork

every(5.minutes, 'fetch.job') do
end
