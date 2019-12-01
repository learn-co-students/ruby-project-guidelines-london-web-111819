class Store < ActiveRecord::Base
    has_many :products
    has_many :orders
    has_many :customers, through: :orders

    def self.find_store(user_input)
        if user_input == "HIGH"
            user_input = 1
        else
            user_input = 2
        end
        @chosen_store = Store.find_by(id: user_input)
    end

    def self.chosen_store
        @chosen_store
    end
    
    def intro
        puts "\n
        Welcome to #{self.name}!\n
        "
    end

    def self.cool_menu
        # add later
    end

    def self.normal_menu
        # add later
    end
end