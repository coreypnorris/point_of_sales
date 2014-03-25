class Product < ActiveRecord::Base
  has_many :goods
  has_many :sales, through: :goods
end
