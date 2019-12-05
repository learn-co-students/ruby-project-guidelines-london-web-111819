class Product < ActiveRecord::Base
    belongs_to :store
    belongs_to :order
    has_many :customers, through: :order

    def self.show_product_by_category
        show = Store.product_category.map do |product|
            "#{product.id}\n#{product.name}\n€#{product.price}.00"
        end
        ids = get_id(show)
        h = show.zip(ids).to_h
    end

    def self.get_id(strings)
        id_arr = strings.map do |s|
            s.split("\n")
            s[0]
            s.to_i
        end
    end

    def self.selected_by_user_message(user_product_id)
        product = Product.find(user_product_id)
        "
        #{product.name} will be added to 'pending orders'
        €#{product.price}.00 will not be deducted until you pay for the product
        do you wish to continue?"
    end

end