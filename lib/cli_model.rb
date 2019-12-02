class CommandLineInterface

    def intro
        intro = TTY::Prompt.new
        intro.keypress("\n
        Welcome to tha project
        Press any key to continue, or wait :countdowns", timeout: 10)
        select_store
    end

    def select_store
        selection = TTY::Prompt.new
        store = selection.select("\nSelect your cool level:\n",
        symbols: pointer) do |intro|
            intro.choice 'Medium', 2
            intro.choice 'HIGH!!!', 1
        end
        Store.find_store(store)
        Store.chosen_store.intro
        if !Customer.logged_in_customer 
            login
        else 
            homepage
        end
    end

    def login
        login = TTY::Prompt.new
        username = login.ask("Yo enter your username before proceeding:\n",
            required: true)
        Customer.validate_username(username)
        homepage
    end

    def homepage
        Customer.logged_in_customer.welcome
        home = TTY::Prompt.new
        home.select("What do u wanna do?", symbols: pointer) do |option|
            option.choice "your profile", -> { profile }
            option.choice "view menu", -> { menu_category }
            option.choice "your orders"
            option.choice "change store", -> { select_store } 
            option.choice "sign out", -> { puts "\nbye
            " } 
        end
    end

    def profile
        Customer.logged_in_customer.view_profile
    end

    # def menu_category
    #     prompt = TTY::Prompt.new
    #     category = prompt.select("Select your category:",
    #     symbols: pointer) do |cat|
    #         cat.choice "Cannabis", { menu }
    #         cat.choice "Drinks", -> { menu }
    #     end
    #     Store.category(category)
    # end

    # def menu
    #     prompt = TTY::Prompt.new
    #     choices = 
    #     menu = prompt.select("choose your product:", Store.category(category),
    #     symbols: pointer)
    # end

    private

    def pointer
        if !Store.chosen_store || Store.chosen_store.id == 2
            {marker: Emoji.find_by_alias("point_right").raw + " "}
        elsif Store.chosen_store.id == 1
            {marker: Emoji.find_by_alias("fu").raw + " "}
        end
    end

end