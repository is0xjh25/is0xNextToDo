module CLI

	# initialization or restart
	def setup
		CLI::username = INITIAL_USER
		CLI::login_failed = false
		CLI::login_attempt = 0
		CLI::rescue_attempt = 0
	end

	def start
					
		puts CLI::make_title("Main Menu") + GAP_LINE

		# options
		question = START + "What's your next move?" + GAP_LINE
		options = {
			"1" => {label: "START", method: "login"},
			QUIT => {label: "QUIT", method: "quit"}
		}
		CLI::make_options(question, options)
	end

	def menu
		CLI::setup
		CLI::start
	end

	def home
		
		puts CLI::make_title("Home") + GAP_LINE
	
		# options
		question = START + "It's you #{CLI::username}! How can I help you?" + GAP_LINE
		options = {
			"1" => {label: "SURPRISE", method: "surprise"},
			"2" => {label: "ADVANCED", method: "advanced"},
			"3" => {label: "COLLECTION", method: "collection"},
			MENU => {label: "MENU", method: "menu"}
		}
		CLI::make_options(question, options)
	end

	def home_guest
		
		puts CLI::make_title("Home") + GAP_LINE
		CLI::username = "Guest"

		# options
		question = START + "Welcome my guest! How can I help you?" + GAP_LINE
		options = {
			"1" => {label: "SURPRISE", method: "surprise_guest"},
			"2" => {label: "ADVANCED", method: "advanced_guest"},
			MENU => {label: "MENU", method: "menu"}
		}
		CLI::make_options(question, options)
	end

	def quit
		puts CLI::make_title("See You Next Time")
		puts GAP_LINE
		puts File.readlines('./resources/favicon.txt')
		puts
		puts File.readlines('./resources/bye.txt') 
		puts GAP_LINE
		print "======Developed by is0xjh25 X Supported by Bored-API======"

		input = CLI::get_char
		exit
	end

	module_function :setup, :start, :menu, :quit, :home, :home_guest
end