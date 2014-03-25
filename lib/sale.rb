class Sale < ActiveRecord::Base
    belongs_to :cashier
    belongs_to :customer
    has_and_belongs_to_many :products
end
