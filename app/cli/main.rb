module CLI

	# initialization or restart
	def setup
		CLI::username = DEFAULT_USER
		CLI::login_failed = false
		CLI::login_attempt = 0
		CLI::rescue_attempt = 0
	end

	# guest and member can access
	def start
					
		puts CLI::make_title("Main Menu") + GAP_LINE

		# options
		question = START + "What's your next move?" + GAP_LINE
		options = {
			"1" => {label: "START", method: "login"},
			QUIT => {label: "QUIT", method: "quit"}
		}
		CLI::make_options(question: question, opt: options)
	end

	# guest and member can access
	def menu
		CLI::setup
		CLI::start
	end

	# guest and member can access
	def home
		
		puts CLI::make_title("Home" + WHITE_SPACE + "(#{CLI::username})") + GAP_LINE
		if CLI::username.downcase == DEFAULT_USER.downcase
			# options
			question = START + "Welcome my guest! How can I help you?" + GAP_LINE
			options = {
				"1" => {label: "SURPRISE", method: "surprise"},
				"2" => {label: "ADVANCED", method: "advanced"},
				MENU => {label: "MENU", method: "menu"}
			}
		else
			question = START + "It's you #{CLI::username}! How can I help you?" + GAP_LINE
			options = {
				"1" => {label: "SURPRISE", method: "surprise"},
				"2" => {label: "ADVANCED", method: "advanced"},
				"3" => {label: "COLLECTION", method: "collection"},
				MENU => {label: "MENU", method: "menu"}
			}
		end
		CLI::make_options(question: question, opt: options)
	end

	# guest and member can access
	def quit
		
		puts CLI::make_title("See You Next Time")
		puts GAP_LINE
		puts File.readlines('./resources/favicon.txt')
		puts
		puts File.readlines('./resources/bye.txt') 
		puts GAP_LINE
		print COPY_RIGHT

		input = CLI::get_char
		exit
	end

	module_function :setup, :start, :menu, :quit, :home
end