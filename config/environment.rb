
require 'io/console'
require 'open-uri'
require 'net/http'
require 'bundler/setup'
Bundler.require

require_relative "../app/models/user.rb"
require_relative "../app/models/activity.rb"
require_relative "../app/models/collection.rb"
require_relative "../app/models/cli.rb"
require_relative "../app/Utilities.rb"


# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/app.sqlite"
)


