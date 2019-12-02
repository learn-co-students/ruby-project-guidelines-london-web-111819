class Store < ActiveRecord::Base
    has_many :products
    has_many :orders
    has_many :customers, through: :orders

    def self.find_store(user_input)
        @chosen_store = Store.find_by(id: user_input)
    end

    def self.chosen_store
        @chosen_store
    end
    
    def intro
        puts "\n
        Welcome to #{self.name}!\n
        "
        if Store.chosen_store.id == 1
          puts "based in Amsterdam,
          "
        end
    end

    # def self.category(user_input)
    #     store = Product.where(store_id: @chosen_store.id, 
    #         category: user_input)
    # end

end