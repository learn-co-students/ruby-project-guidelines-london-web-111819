class Customer < ActiveRecord::Base
    has_many :orders
    has_many :stores, through: :orders
    has_many :products, through: :orders

end