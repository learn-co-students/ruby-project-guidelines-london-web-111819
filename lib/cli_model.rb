class CommandLineInterface

    def intro
        intro = TTY::Prompt.new
        intro.keypress("\n
        Welcome to tha project
        Press any key to continue, or wait :countdowns", timeout: 10)
        selection = intro.select("\nSelect your cool level:\n", %w(Medium HIGH))
        Store.find_store(selection)
        Store.chosen_store.intro
    end

end