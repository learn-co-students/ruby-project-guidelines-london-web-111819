class Product < ActiveRecord::Base
    belongs_to :store

    def self.show_product_by_category
        Store.product_category.map do |product|
            "#{product.id}\nThe #{product.name}\n€#{product.price}.00\nPreparation time: #{product.prep_time}s"
        end
        # puts Product.where(category: Store.product_category)
    end

end