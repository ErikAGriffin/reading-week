require './app/server'

use Rack::Static, root: 'public', urls:['/styles']


run Server.new
