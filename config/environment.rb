require 'bundler/setup'
Bundler.require

# put the code to connect to the database here
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/app.sqlite"
)

require_relative "../lib/user.rb"
