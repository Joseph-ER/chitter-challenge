# file: lib/database_connection.rb

require 'pg'

# This class is a thin "wrapper" around the
# PG library. We'll use it in our project to interact
# with the database using SQL.

class DatabaseConnection
  # This method connects to PostgreSQL using the 
  # PG gem. We connect to 127.0.0.1, and select
  # the database name given in argument.
# file: lib/database_connection.rb

  def self.connect(database_name)
    # If the environment variable (set by Heroku)
    # is present, use this to open the connection.
    if ENV['DATABASE_URL'] != nil
      @connection = PG.connect(ENV['DATABASE_URL'])
      return
    end

    if ENV['ENV'] == 'test'
      database_name = 'chitter_db_test'
    else
      database_name = 'chitter_db'
    end
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  # This method executes an SQL query 
  # on the database, providing some optional parameters
  # (you will learn a bit later about when to provide these parameters).
  def self.exec_params(query, params)
    @connection.exec_params(query, params)
  end
end

