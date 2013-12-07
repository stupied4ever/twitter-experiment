begin
  require 'ci/reporter/rake/rspec'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

require 'resque/tasks'
require_relative 'config/boot'

namespace :db do
  task :seed, :file do |t, args|
    if args[:file]
      feeds_file = args[:file]
    else
      feeds_file = if ENV['ENVIRONMENT'] == 'development'
                     'config/feeds_development.yml'
                   else
                     'config/feeds.yml'
                   end
    end
    puts "Importing from file: #{feeds_file}"

    YAML.load_file(feeds_file).each do |provider|
      provider['feeds'].each do |feed|
        feed.store('provider', provider['provider'])
        if Sources::RSS.new(feed).save
          puts "Importado -> #{feed['address']}"
        end
      end
    end
  end
end
