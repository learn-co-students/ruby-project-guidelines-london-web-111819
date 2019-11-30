class Order < ActiveRecord::Base
    belongs_to :customer
    belongs_to :store
    has_many :products, through: store

end