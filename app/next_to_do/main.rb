module NextToDo

	# initialization or restart
	def setup
		NextToDo::username = DEFAULT_USER
		NextToDo::login_failed = false
		NextToDo::login_attempt = 0
		NextToDo::rescue_attempt = 0
	end

	# guest and member can access
	def start
					
		puts make_title("Main Menu") + GAP_LINE

		# options
		question = START + "What's your next move?" + GAP_LINE
		options = {
			"1" => {label: "START", method: "login"},
			QUIT => {label: "QUIT", method: "quit"}
		}
		make_options(question: question, opt: options)
	end

	# guest and member can access
	def menu
		setup
		start
	end

	# guest and member can access
	def home
		
		puts make_title("Home" + WHITE_SPACE + "(#{NextToDo::username})") + GAP_LINE
		if NextToDo::username.downcase == DEFAULT_USER.downcase
			# options
			question = START + "Welcome my guest! How can I help you?" + GAP_LINE
			options = {
				"1" => {label: "SURPRISE", method: "surprise"},
				"2" => {label: "ADVANCED", method: "advanced"},
				MENU => {label: "MENU", method: "menu"}
			}
		else
			question = START + "It's you #{NextToDo::username}! How can I help you?" + GAP_LINE
			options = {
				"1" => {label: "SURPRISE", method: "surprise"},
				"2" => {label: "ADVANCED", method: "advanced"},
				"3" => {label: "COLLECTION", method: "collection"},
				MENU => {label: "MENU", method: "menu"}
			}
		end
		make_options(question: question, opt: options)
	end

	# guest and member can access
	def quit
		
		question = START + "Are you sure want to leave us?" + GAP_LINE
		options = {
			NO => {label: "NO", method: nil},
			YES => {label: "YES", method: nil},
		}
		confirm = make_options(question: question, opt: options)

		if confirm == NO
			menu
		elsif confirm == YES
			puts make_title("See You Next Time")
			puts GAP_LINE
			puts File.readlines('./resources/favicon.txt')
			puts
			puts File.readlines('./resources/bye.txt') 
			puts GAP_LINE
			print COPY_RIGHT
	
			input = get_char
			exit
		end
	end

	module_function :setup, :start, :menu, :quit, :home
end