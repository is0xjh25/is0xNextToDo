require 'bundler/setup'
Bundler.require
require_relative "../app/models/user.rb"

# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/app.sqlite"
)


