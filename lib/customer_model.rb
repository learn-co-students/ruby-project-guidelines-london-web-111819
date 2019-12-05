class Customer < ActiveRecord::Base
    has_many :orders
    has_many :stores, through: :orders
    has_many :products, through: :orders

    def self.validate_username(user_login)
        @customer = Customer.find_by!(username: user_login)
        # if customer_check.eligible?
        #     @customer = customer_check
        # end
    end

    def eligible?
        self.age < 18 && Store.chosen_store.id == 1
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
        puts "favourite store: #{favourite_store.name}
        "
        # puts self.orders.count
    end

    def favourite_store
        store_ids = self.products.map do |product|
            product.store_id
        end
        max_store_id =  store_ids.max_by { |id| store_ids.count(id) }
        Store.find(max_store_id)
    end

    def pending_orders
        pending = self.orders.where(status: "pending")
        ids = pending.map do |order|
            order.product_id
            end
        products = Product.where(id: ids)
        products.map do |product|
            "#{product.name}\nAmount to pay:€#{product.price}.00\nProduct category: #{product.category}"
        end
    end

    def completed_orders
        completed = self.orders.where(status: "completed")
        if 
            completed == []
            puts "you have no orders!"
        else
            ids = completed.map do |order|
                order.product_id
                end
            products = Product.where(id: ids)
            products.map do |product|
                "#{product.name}\nYou paid: €#{product.price}.00\nProduct category: #{product.category}"
            end
        end
    end

    def pending_orders_hash
        usernames1 = pending_orders.map do |p|
            p.split("\n")
        end
        usernames2 = usernames1.map do |u|
            u[0]
        end
        h = pending_orders.zip(usernames2).to_h
    end
        
    def create_order(user_input_id)
        product = Product.find(user_input_id)
        Order.create(
            status: "pending",
            time_left: product.prep_time,
            cost: product.price,
            customer_id: self.id,
            store_id: product.store_id,
            product_id: user_input_id)
    end

    def edit_order(name_input)
        product = Product.find_by(name: name_input)
        product.name
    end

    def pay_for_product(name_input)
        product_to_pay_for = self.products.find_by(name: name_input)
        order_to_pay_for = self.orders.select do |order|
            order.product_id == product_to_pay_for.id
        end
        if self.balance - product_to_pay_for.price >= 0
            self.update(balance: self.balance -= product_to_pay_for.price)
            puts order_to_pay_for[0]
            order_to_pay_for[0].update(status: "completed")
            puts "successfully bought product!"
        else 
            puts "
            cannnot complete payment for product:
            insufficient balance.
            "
        end
    end

    def delete_order(name_input)
        product_to_delete = self.products.find_by(name: name_input)
        order_to_delete =  self.orders.select do |order|
            order.product_id == product_to_delete.id
        end
        self.update(balance: self.balance += product_to_delete.price)
        order_to_delete[0].destroy
    end

    def add_balance(gamble)
        self.update(balance: self.balance += gamble)
    end

    def remove_balance(gamble)
        self.update(balance: self.balance -= gamble)
    end
    
end