require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'

ActiveRecord::Base.logger = nil

# Giphy::Configuration.configure do |config|
#     # config.version = "0.9.3"
#     config.api_key = "XgyBBmOoqISIHW9mblZJDtfIJbK5s3Q7"
#   end