class CommandLineInterface


    def intro    
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        title: {top_left: "  WELCOME  ", bottom_right: "  PROJECT BY ME !  "},
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
        Welcome to tha project
        Press any key to continue, or wait :countdowns"
        end
        puts keypress(box)
        select_store
    end

    def select_store
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        title: {top_left: "  SELECT YOUR STORE  ", bottom_right: "  THE COOL STORE IS 18+  "},
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
            SELECT YOUR COOL LEVEL!:" 
        end
        select_method(box)
        store_intro
        if !Customer.logged_in_customer || Customer.logged_in_customer.eligible?
            login
        else 
            homepage
        end
    end

    def store_intro
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        title: {top_left: "  #{@store.name}  ", bottom_right: "  18 + !!! LOGIN TO CONFIRM YOUR AGE  "},
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
        WELCOME TO #{@store.name}.
        We're based in Amsterdam and differ from most other stores
        See for yourself, but first:"
        end
        puts box
    end

    def login
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
        Yo enter your username before proceeding:
        "
        end
        login_box(box)
        Customer.validate_username(@username)
        validate_age
        homepage
    end

    def validate_age
        if Customer.logged_in_customer.eligible?
            puts "
            This store is 18+ only. #{Emoji.find_by_alias("no_entry").raw}
            "
            select_store
        end
    end

    def homepage
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
        Hellooo #{Customer.logged_in_customer.username}
        What do u wanna do???
        "
        end
        homescreen_box(box)
    end

    def profile
        Customer.logged_in_customer.view_profile
        go_back = TTY::Prompt.new
        go_back = go_back.keypress("
        Press any key to return to the homescreen
        ")
        homepage
    end

    def menu_category
        prompt = TTY::Prompt.new
        category = prompt.select("Select your category:",
        symbols: pointer) do |cat|
            cat.choice "Cannabis"
            cat.choice "Drinks"
            cat.choice "Hacking Tutorials"
        end
        @product_pointer = Store.category(category)
        menu
    end

    def menu
        prompt = TTY::Prompt.new
        choices = 
        menu = prompt.select("choose your product:\n\n", 
        Product.show_product_by_category,
        symbols: product_pointer)
        @product_id = menu
        confirmation_screen
    end

    def confirmation_screen
        tty = TTY::Prompt.new
        tty.select(Product.selected_by_user_message(@product_id),
        symbols: pointer) do |q|
            q.choice "yes", -> { create_order }
            q.choice "no, return to product catalog", -> { menu_category }
            q.choice "no, return to homepage", -> { homepage }
        end
    end
    
    def create_order
        Customer.logged_in_customer.create_order(@product_id)
        puts "returning to homepage ..."
        homepage
    end

    def games
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        title: {top_left: "WELCOME TO GAMES!", bottom_right: "YOUR CURRENT BALANCE IS €#{Customer.logged_in_customer.balance}.00"},
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n
            Here we allow our customers to play various
            different games and gamble their money for a chance
            to afford the higher-priced items ... #{Emoji.find_by_alias("wink").raw}"
        end
        puts box
        if Customer.logged_in_customer.balance == 0
            prompt = TTY::Prompt.new
            prompt.error("\nLooks like u have no money and you're broke")
            return_to_homepage
            return
        end
        tty = TTY::Prompt.new
        tty.select("\nTake a pick:\n",
        symbols: pointer) do |q|
            q.choice "Coin Flip", -> { coin_flip }
            q.choice "Rock Paper Scissors", -> { rock_paper_scissors }
        end
    end

    def rock_paper_scissors
        gamble_slider
        prompt = TTY::Prompt.new
        prompt.warn("You've put €#{@gamble}.00 on the line.")
        tty = TTY::Prompt.new
        @rps_prompt = tty.select("\n Choose your option:",
        symbols: pointer) do |q|
            q.choice "#{Emoji.find_by_alias("punch").raw}", 1
            q.choice "#{Emoji.find_by_alias("hand").raw}", 2
            q.choice "#{Emoji.find_by_alias("v").raw}", 3
        end
        gamble_rps
    end

    def coin_flip
        gamble_slider
        prompt = TTY::Prompt.new
        prompt.warn("You've put €#{@gamble}.00 on the line.")
        tty = TTY::Prompt.new
        @cf_prompt = tty.select("\n HEADS or TAILS???",
        symbols: pointer) do |q|
            q.choice "HEADS", 1
            q.choice "TAILS", 2
        end
        gamble_cf
    end

    def gamble_rps
        prompt = TTY::Prompt.new
        random = ["#{Emoji.find_by_alias("punch").raw}", "#{Emoji.find_by_alias("hand").raw}", "#{Emoji.find_by_alias("v").raw}"].sample
        puts "\nThe computer has picked #{random}"
        if @rps_prompt == 1 && random == "#{Emoji.find_by_alias("v").raw}" || @rps_prompt == 2 && random == "#{Emoji.find_by_alias("punch").raw}" || @rps_prompt == 3 && random == "#{Emoji.find_by_alias("hand").raw}"
            prompt.ok("\nYou win €#{@gamble}!")
            Customer.logged_in_customer.add_balance(@gamble)
            return_to_homepage
        elsif @rps_prompt == 1 && random == "#{Emoji.find_by_alias("punch").raw}" || @rps_prompt == 2 && random == "#{Emoji.find_by_alias("hand").raw}" || @rps_prompt == 3 && random == "#{Emoji.find_by_alias("v").raw}"
            prompt.warn("\nIt's a draw")
            return_to_homepage
        else
            prompt.error("\nUnlucky you lost €#{@gamble}")
            Customer.logged_in_customer.remove_balance(@gamble)
            return_to_homepage
        end
    end

    def gamble_cf
        prompt = TTY::Prompt.new
        random = ["HEADS", "TAILS"].sample
        # puts Giphy.random.display
        # # binding.pry
        puts "\n The coin landed on #{random}."
        if @cf_prompt == 1 && random == "HEADS" || @cf_prompt == 2 && random == "TAILS"
            prompt.ok("\n You win €#{@gamble}!")
            Customer.logged_in_customer.add_balance(@gamble)
            return_to_homepage
        else
            prompt.error("\nUnlucky you lost €#{@gamble}")
            Customer.logged_in_customer.remove_balance(@gamble)
            return_to_homepage
        end
    end

    def your_orders
        prompt = TTY::Prompt.new
        prompt = prompt.select("select the order u want to view:\n", 
        symbols: pointer) do |q|
            q.choice "Pending orders basket", -> { pending_orders }
            q.choice "Completed orders", -> { completed_orders }
            q.choice "Back", -> { homepage }
        end
    end

    def pending_orders
        prompt = TTY::Prompt.new
        propmt = prompt.select("select the order:\n",
        Customer.logged_in_customer.pending_orders_hash, 
        symbols: pointer)
        @pending_order = propmt
        edit_order
    end

    def completed_orders
        prompt = TTY::Prompt.new
        propmt = prompt.select("select the order:\n", 
        Customer.logged_in_customer.completed_orders, 
        symbols: pointer)
        back = TTY::Prompt.new
        back = prompt.keypress("press any key to return to homepage\n")
        homepage
    end

    def edit_order
        puts Customer.logged_in_customer.edit_order(@pending_order)
        tty = TTY::Prompt.new
        tty.select("what do you wanna do?:",
            symbols: pointer) do |q|
            q.choice "pay for an order", -> { pay_for_order }
            q.choice "remove from basket", -> { delete_order }
            q.choice "back", -> { homepage }
        end
    end

    def pay_for_order
        Customer.logged_in_customer.pay_for_product(@pending_order)
        homepage
    end

    def delete_order
        Customer.logged_in_customer.delete_order(@pending_order)
        puts "order cancelled!"
    end

    def sign_out
        box = TTY::Box.frame(width: 95, height: 8,
        border: :thick,
        align: :center,
        title: {top_left: "  GOODBYE #{Customer.logged_in_customer.username}  ", bottom_right: "  HOPE YOU ENJOYED THE PROJECT  "},
        style: {fg: :magenta, bg: :black,
        border: {fg: :black, bg: :magenta}}) do
            "\n\nHope you had fun!"
        end
        puts box
    end

    private

    def pointer
        if !@store || @store.id == 2
            {marker: Emoji.find_by_alias("point_right").raw + " "}
        elsif @store.id == 1
            {marker: Emoji.find_by_alias("fu").raw + " "}
        end
    end

    def product_pointer
        if @product_pointer == Store.category("Cannabis")
            {marker: Emoji.find_by_alias("leaves").raw + " "}
        elsif @product_pointer == Store.category("Drinks")
            {marker: Emoji.find_by_alias("beer").raw + " "}
        elsif @product_pointer == Store.category("Hacking Tutorials")
            {marker: Emoji.find_by_alias("floppy_disk").raw + " "}
        end
    end

    def keypress(string)
        tty = TTY::Prompt.new
        intro = tty.keypress(string, timeout: 7)
    end

    def select_method(box)
        tty = TTY::Prompt.new
        store = tty.select(box, symbols: pointer) do |intro|
            intro.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :yellow, bg: :black,
            }) do
                "\n

                Medium"
            end,2)
            intro.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :red, bg: :black,
            }) do
                "\n

                HIGH!!!"
            end,1)
        end
        @store = Store.find_store(store)
    end

    def login_box(box)
        login = TTY::Prompt.new
        @username = login.ask(box,
            required: true)
    end

    def homescreen_box(box)
        home = TTY::Prompt.new
        home.select(box, symbols: pointer) do |option|
            option.default 6
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\nyour profile"
            end, -> { profile })
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\nview product catalog"
            end, -> { menu_category })
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            left: 100,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\ngames"
            end, -> { games })
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\nyour orders"
            end, -> { your_orders })
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\nchange store"
            end, -> { select_store })
            option.choice(box = TTY::Box.frame(width: 93, height: 7,
            border: { type: :light, bottom: false, top: false, left: false, right: false },
            align: :center,
            style: {fg: :magenta, bg: :black,
            }) do
                "\n\n\nsign out"
            end, -> { sign_out })
        end
    end

    def gamble_slider
        prompt = TTY::Prompt.new
        @gamble = prompt.slider("\nHow much do u wanna put on it\n", max: Customer.logged_in_customer.balance, min: 1, 
            step: 1, #default: 1,
        symbols: {bullet: "#{pointer.values[0]}"},
        format: "|:slider| €%d.00",
        border: "£")
        # end
    end

    def return_to_homepage
        tty = TTY::Prompt.new
        tty.keypress("\nReturning to homepage in :countdowns ...", timeout: 5, keys: [:space])
        homepage
    end

end