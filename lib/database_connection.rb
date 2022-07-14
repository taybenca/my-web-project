# file: lib/database_connection.rb
require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end
end


class DatabaseConnection
  def self.connect
    # If the environment variable (set by Heroku)
    # is present, use this to open the connection.
  if ENV['DATABASE_URL'] != nil
    @connection = PG.connect(ENV['DATABASE_URL'])
    return
  end
    
  if ENV['ENV'] == 'test'
    database_name = 'music_library_test'
  else
    database_name = 'music_library'
  end
  @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end
end