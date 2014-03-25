class Sale < ActiveRecord::Base
    belongs_to :cashier
    belongs_to :customer
    has_many :goods
    has_many :products, through: :goods
end
