require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require 'cashier'
require 'product'
require 'sale'
require 'customer'

database_configuration = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configuration["test"]
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Cashier.all.each { |cashier| cashier.destroy }
    Product.all.each { |product| product.destroy }
  end
end
