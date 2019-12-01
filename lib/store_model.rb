class Store < ActiveRecord::Base
    has_many :products
    has_many :orders
    has_many :customers, through: :orders

end