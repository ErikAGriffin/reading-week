  #DataMapper::Logger.new($stdout, :debug)

  environment = ENV['RACK_ENV'] || 'development'

  # Read into what this line does, ways of setting up multiple environments

  DataMapper.setup(:default, "postgres://localhost/reading_week_#{environment}")



  require './app/model/user'
  require './app/model/project_idea'


  DataMapper.finalize

# After switching databases, I was getting repeated errors,
# and running the rake file did not help.
# Finally when I put the line back in this file, rspec
# ran and I could remove it once again.
#        DataMapper.auto_migrate!
