require "bundler/setup"

# require 'active_support'
require 'active_record'
# require 'action_controller'
# require 'rails'
require "database_cleaner"
require "byebug"
require "qbwc_workers"
require "qbxml"


load "spec/database.rb"

RSpec.configure do |config|

  def import_records(entity_name)
    subject.handle_response(load_query(entity_name),nil,nil,nil,nil)
  end

  def load_query(query_name)
    YAML.load(File.read("spec/support/queries/#{query_name}.yml"))
  end



  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
