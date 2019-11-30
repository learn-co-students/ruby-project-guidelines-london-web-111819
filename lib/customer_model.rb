class Customer < ActiveRecord::Base
    has_many :orders
    has_many :stores, through: :order
    has_many :products, through: :order

end