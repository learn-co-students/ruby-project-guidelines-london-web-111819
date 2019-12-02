class Product < ActiveRecord::Base
    belongs_to :store

    def show_product
    end
    
end