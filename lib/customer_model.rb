class Customer < ActiveRecord::Base
    has_many :orders
    has_many :stores, through: :orders
    has_many :products, through: :orders

    def self.validate_username(user_login)
        @customer = Customer.find_by!(username: user_login)
    end

    def eligible?
        if self.age < 18 && Store.chosen_store.id == 1
            puts "too young"
        end
    end

    def self.logged_in_customer
        @customer
    end

    def welcome
        puts "\nhello #{self.username}!
        "

    end

    def view_profile
        puts "\nWhatsup #{self.username}
        "
        puts "balance: €#{self.balance}.00
        "
        puts "age: #{self.age}
        "
        puts orders
    end

    private

    def orders
        Order.find_by(id: self.id)
    end
end