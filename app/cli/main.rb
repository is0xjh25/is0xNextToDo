module CLI

	# initialization or restart
	def setup
		CLI::username = INITIAL_USER
		CLI::menu_visited = false
		CLI::login_failed = false
		CLI::login_attempt = 0
	end
	module_function :setup

	def start
					
		puts CLI::make_title("Get Started") + GAP_LINE

		# options
		question = START + "What's your next move?" + GAP_LINE
		options = {
			"1" => {label: "START", method: "login"},
			QUIT => {label: "QUIT", method: "quit"}
		}

		CLI::make_options(question, options)
	end
	module_function :start

	def menu
		CLI::setup
		CLI::start
	end
	module_function :menu

	def home_page
			
		puts CLI::make_title("Home") + GAP_LINE
		
		# options
		if !CLI::menu_visited
			question = START + "It's you #{CLI::username}! How can I help you?" + GAP_LINE
			CLI::menu_visited = true
		else 
			question = nil
		end

		options = {
			"1" => {label: "SURPRISE", method: "surprise"},
			"2" => {label: "ADVANCED", method: "advanced"},
			"3" => {label: "COLLECTION", method: "collection"},
			MENU => {label: "MENU", method: "menu"}
		}

		CLI::make_options(question, options)
	end
	module_function :home_page

	def quit
		puts CLI::make_title("See You Next Time")
		puts
		puts File.readlines('./resources/bye.txt')
		puts
		puts "======Developed by is0xjh25 X Supported by Bored-API======"
		puts
		exit
	end
	module_function :quit
end