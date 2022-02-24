class Cli

	# Static Variables
	INITIAL_USER = "Unknown User"
	GAP_LINE = "\n\n"
	VER = "|"
	HOR = "~"
	DIVIDER_LENGTH = 60
	DIVIDER_SYMBOL = "="
	DIVIDER = "============================================================"
	EMPHASIZE_SYMBOL_F = "<<< "
	EMPHASIZE_SYMBOL_E = " >>>"
	START = "[is0]: " 
	START_WARNING = "[WARNING]: "
	START_ERROR = "[ERROR]: "
	WHITE_SPACE = " "
	QUIT = "Q"
	MENU = "M"
	HOME = "H"
	BACK = "B"
	MAX_INPUT_ATTEMPT = 10
	MAX_LOGIN_ATTEMPT = 5	

	attr_accessor :username, :home_page_visited, :login_failed

	def initialize
		setup
	end

	# start the CLI
	def call
		
		puts make_page_title("Welcome to NextToDo")
		puts GAP_LINE
		puts File.readlines('./resources/favicon.txt')
		puts
		puts File.readlines('./resources/hello.txt')
		puts GAP_LINE
		print make_page_title("Developed by is0xjh25")
		
		input = get_char

		if input != "q"
			puts GAP_LINE
			puts File.readlines('./resources/app-description.txt')
			puts
			start
		else
			quit
		end
	end

	private

	# initialization or restart
	def setup
		@username = INITIAL_USER
		@home_page_visited = false
		@login_failed = false
		@login_attempt = 0
	end

	def start
				
		puts make_page_title("Get Started") + GAP_LINE

		# options
		question = START + "What's your next move?" + GAP_LINE
		options = {
			"1" => {label: "START", method: "login"},
			"Q" => {label: "QUIT", method: "quit"}
		}

		make_options(question, options)
	end

	def login

		puts make_page_title("Login") + GAP_LINE

		# options
		question = START + "Do you have an account already?" + GAP_LINE
		options = {
			"1" => {label: "LOGIN", method: "login_member"},
			"2" => {label: "CREATE ONE", method: "login_create_account"},
			"3" => {label: "BE GUEST", method: "login_create_account"}
		}

		make_options(question, options)
	end

	def login_member

		if !@login_failed
			puts START + "Great! Tell me your username." + GAP_LINE
		elsif @login_failed && @login_attempt > MAX_LOGIN_ATTEMPT
			begin
				raise CliError
			rescue CliError => error
				puts error.excessive_login_attempt
			end
		else
			puts START + "I love you attitude. Let's try again" + GAP_LINE
			puts START + "Your username, please." + GAP_LINE
		end

		username = puts_long_promot
		puts START + "And password. Don't worry, I won't tell anyone :)" + GAP_LINE
		print "[#{@username}]: "
		password = STDIN.noecho(&:gets).chomp
		puts GAP_LINE

		# success or fail
		if username == "asd" && password == "asd"
			@username = "Yun-Chi"
			@login_failed = false
			@login_attempt = 0
			home_page
		else
			@login_failed = true
			@login_attempt += 1
			puts START_WARNING + "The email or password is incorrect." + GAP_LINE
			puts START + "Calm down buddy. I will help you out." + GAP_LINE
			# options
			question = START + "Pick one." + GAP_LINE
			options = {
				"1" => {label: "TRY AGAIN", method: "login_member"},
				"2" => {label: "RESCUE", method: "login_rescue"},
				"3" => {label: "BE GUEST", method: "login_create_account"}
			}
	
			make_options(question, options)
		end
	end

	def login_create_account

		puts make_page_title("Create Account") + GAP_LINE
		puts START + "is0xNextToDo welcomes you!" + GAP_LINE
		
		# username
		puts START + "Enter your new username." + GAP_LINE
		username = puts_long_promot
		while username == "asd"
			puts START_WARNING + "The username has been used." + GAP_LINE
			puts START + "Pick another one." + GAP_LINE
			username = puts_long_promot
		end

		# email
		puts START + "Enter your email." + GAP_LINE
		email_validate = false
		while !email_validate
			
			email = puts_long_promot

			if !is_valid_email?(email)
				puts START_WARNING + "The email is not valid. Please check it again." + GAP_LINE
			else
				email_validate = true
			end
		end

		while email == "asd@gmail.com"
			puts START_WARNING + "The email has been used." + GAP_LINE
			puts START + "Try another one." + GAP_LINE
			username = puts_long_promot
		end

		# password
		puts START + "Make a password." + GAP_LINE
		password_validate = false
		while !password_validate
			print "[#{@username}]: "
			password = STDIN.noecho(&:gets).chomp
			puts GAP_LINE
			puts START + "Enter your password again." + GAP_LINE
			print "[#{@username}]: "
			password_1 = STDIN.noecho(&:gets).chomp
			puts GAP_LINE
			
			if password == password_1
				password_validate = true
			else
				puts START_WARNING + "The entered passwords don't match." + GAP_LINE
				puts START + "Please type it again." + GAP_LINE
				password_validate = false
			end
		end

		# create account
		puts START + "Your account has been created." + GAP_LINE
		puts START + "Here is your account information." + GAP_LINE
		# account info table
		# set @username
		puts START + "Thank you for join is0xNextToDo." + GAP_LINE
		puts home_page
	end

	def login_rescue

		puts make_page_title("Rescue Account") + GAP_LINE
		puts START + "The rescue team is here!" + GAP_LINE

		question = START + "Give me some information about you." + GAP_LINE
		opts = " [1]Username [2]Email "
		opts_arr = ["1", "2"]
		selected = offer_options(question, opts, opts_arr)

		puts START + "I'm listening."+ GAP_LINE
		reply = puts_promot

		if selected == "1" && reply == "qwe"
			puts START + "Found it!" + GAP_LINE
			puts START + "Here is your account information." + GAP_LINE
			puts START + "Don't lose it :)" + GAP_LINE
			menu
		elsif selected == "2" && reply == "qwe@gmail.com"
			puts START + "Found it!" + GAP_LINE
			puts START + "Here is your account information." + GAP_LINE
			puts START + "Don't lose it :)" + GAP_LINE
			menu
		else
			puts START + "Sorry, I don't see you in the database" + GAP_LINE
			question_1 = START + "Should we move on?" + GAP_LINE
			opts_1 = " [1]Call for help [2]Create account [3]Login as guest "
			opts_arr_1 = ["1", "2", "3"]
			selected_1 = offer_options(question_1, opts_1, opts_arr_1)

			if selected_1 == "1"
				login_rescue
			elsif selected_1 == "2"
				login_create_account
			elsif selected_1 == "3"
				@username = "Guest"
				home_page
			else
				begin
					raise CliError
				rescue CliError => error
					puts error.option_message
				end
			end
		end
	end

	def home_page
		
		puts make_page_title("Home") + GAP_LINE
		
		if !@home_page_visited
			question = START + "It's you #{username}! How can I help you?" + GAP_LINE
			@home_page_visited = true
		else 
			question = nil
		end

		opts = " [1]Surprise [2]Advanced [3]Collection [4]menu "
		opts_arr = ["1", "2", "3", "4"]
		selected = offer_options(question, opts, opts_arr)

		if selected == "1"
			surprise
		elsif selected == "2"
			advanced
		elsif selected == "3"
			collection
		elsif selected == "4"
			menu
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.option_message
			end
		end
	end

	def surprise

		puts make_page_title("Surprise") + GAP_LINE
		puts "COOOOOOOOOOOOOL" + GAP_LINE

		question =  START + "Here you go! What to do next?" + GAP_LINE
		opts = " [1]Next [2]Save it [3]Home "
		opts_arr = ["1", "2", "3"]
		selected = offer_options(question, opts, opts_arr)
	
		if selected == "1"
			surprise
		elsif selected == "2"
			puts START + "It's has been save to your collection"
			home_page
		elsif selected == "3"
			home_page
		else 
			begin
				raise CliError
			rescue CliError => error
				puts error.option_message
			end
		end
	end

	def advanced
		
		puts make_page_title("Advanced") + GAP_LINE
		
		question = "Type?"
		opts = " [1]Education [2]Recreational [3]Social [4]Charity [5]Cooking [6]Relaxation [7]Music [8]Busywork "
		opts_arr = ["1", "2", "3", "4", "5", "6", "7", "8"]
		type = offer_options(question, opts, opts_arr)

		puts "[is0]: Accessibility? (Easy->Hard = 0->1)" + GAP_LINE
		accessibility = puts_promot
		puts "[is0]: Price? (Free->Paid = 0->1)" + GAP_LINE
		price = puts_promot
		puts "[is0]: Participants? (0->N)" + GAP_LINE
		participants = puts_promot
	end

	def collection
	end

	def menu
		setup
		start
	end

	def quit
		puts make_page_title("See You Next Time")
		puts
		puts File.readlines('./resources/bye.txt')
		puts
		puts "======Developed by is0xjh25 X Supported by Bored-API======"
		puts
		exit
	end

	# Helper Functions

	# support reading sinlge input and control-c command
	def get_char
		state = `stty -g`
		`stty raw -echo -icanon isig`
		STDIN.getc.chr
		ensure
		`stty #{state}`
	end

	def puts_options(options)
				
		content_length = DIVIDER_LENGTH
		line = ""

		if [2, 3, 4].include? options.size
			option_length = content_length / options.size
			options.each do |key, info|
				label = info[:label]
				# 1  WhiteSpace + [1] + 1 WhiteSpace + START + the rest of gap
				overall_length = 2 + key.size + label.size
				if option_length >= overall_length
					line += WHITE_SPACE + "[#{key}]" + WHITE_SPACE + "#{label}" + WHITE_SPACE * (option_length - overall_length + 1)
				else
					begin
						raise CliError
					rescue CliError => error
						puts error.option_size
					end
				end  
			end
		elsif options.size == 8
		# 
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.options_overload
			end
		end

		# option box
		puts HOR * DIVIDER_LENGTH
		puts line
		puts HOR * DIVIDER_LENGTH
		puts
	end

	def puts_short_promot
		print "[#{@username}]: "
		input = get_char.downcase
		print input + GAP_LINE
		input
	end

	def puts_long_promot
		print "[#{@username}]: "
		input = get_strip.downcase
		print input + GAP_LINE
		input
	end

	def make_options(question, options)
		warning_count = 0
		puts question
		puts_options(options) 
		input = puts_short_promot

		while !options.has_key?(input)
			if warning_count > MAX_INPUT_ATTEMPT
				begin
					raise CliError
				rescue CliError => error
					puts error.excessive_warning
					quit
				end
			end
			puts START_WARNING + "Please enter a valid CHARACTER or NUMBER." + GAP_LINE
			input = puts_short_promot
			warning_count += 1
		end

		self.send(options[input][:method])
	end

	def offer_options(question, opts, opts_arr)
		
		puts question
		puts_options(opts) 
		selected = puts_short_promot

		while !opts_arr.include? selected 
			puts START + "Please enter a valid number!" + GAP_LINE
			selected = puts_promot
		end

		selected
	end

	def is_valid_email?(email)
		email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end

	def make_page_title(text)
		
		symbol_length = (DIVIDER_LENGTH - text.size) / 2 - EMPHASIZE_SYMBOL_F.size
		str = DIVIDER_SYMBOL * symbol_length + EMPHASIZE_SYMBOL_F

		if text.size % 2 == 1
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * (symbol_length + 1)
		else
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * symbol_length
		end
		
		str
	end

	# Error Class for testing
	class CliError < StandardError

		def excessive_warning
			puts START_ERROR + "Retard Alert!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons." + GAP_LINE
		end

		def excessive_login_attempt
			puts START_ERROR + "Just take a rest!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons." + GAP_LINE
		end

		def options_overload
			START_ERROR + "Invalid number of options. Only accept 2, 3, 4, 8."
		end

		def option_too_long
			START_ERROR + "Text for option needs to be shorten."
		end
	end
  
end