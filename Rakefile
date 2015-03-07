require 'data_mapper'
require './app/data_mapper_setup.rb'


task :auto_upgrade do

  DataMapper.auto_upgrade!
  puts "Auto Upgrade complete."
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts "Auto Migrate complete (tables reset)."
end
