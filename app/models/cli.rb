class Cli

	GAP = "\n\n"
	DIVIDER = "=========================================================="
	START_SECTION = DIVIDER + GAP
	END_SECTION = DIVIDER + GAP
	START_INDICATION = "[is0]: "
	VER = "|"
	HOR = "~"
	INITIAL_USER = "Unknown User"

	attr_accessor :username, :home_page_visited, :login_failed

	def initialize
		setup
	end

	# start the CLI
	def call
		puts START_SECTION
		puts File.readlines('./resources/favicon.txt')
		puts
		puts File.readlines('./resources/hello.txt')
		puts
		puts "===================Welcome to NextToDo!==================="
		puts
		puts File.readlines('./resources/app-description.txt')
		puts
		puts "I guess you are bored now." + GAP 
		puts "Let's get some FUN!" + GAP
		puts END_SECTION
		start
	end

	private

	def setup
		@username = INITIAL_USER
		@home_page_visited = false
		@login_failed = false
	end

	def start
		
		puts START_SECTION
		puts "$$$ Get Started $$$" + GAP

		question = START_INDICATION + "What's your next move?" + GAP
		opts = " [1]Start [2]Leave "
		opts_arr = ["1", "2"]
		selected = offer_options(question, opts, opts_arr)

		
		if selected == "1"
			login
		elsif selected == "2"
			puts END_SECTION
			leave
		else
		  	puts "ERROR!!!"
		end
	end

	def login

		puts START_SECTION
		puts "$$$ Login $$$" + GAP
		question = START_INDICATION + "Do you have an account already?" + GAP
		opts = " [1]Got one [2]Create account [3]Login as guest "
		opts_arr = ["1", "2", "3"]
		selected = offer_options(question, opts, opts_arr)

		if selected == "1"
			login_member
		elsif selected == "2"
			puts END_SECTION
			login_create_user
		elsif selected == "3"
			puts END_SECTION
			@username = "Guest"
		  	home_page
		else
		  	puts "ERROR!!!"
		end
	end

	def login_rescue

		puts START_INDICATION + "The rescue team is here!" + GAP

		question = START_INDICATION + "Give me some information about you." + GAP
		opts = " [1]Username [2]Email "
		opts_arr = ["1", "2"]
		selected = offer_options(question, opts, opts_arr)

		puts START_INDICATION + "I'm listening."+ GAP
		reply = puts_promot

		if selected == "1" && reply == "qwe"
			puts START_INDICATION + "Found it!" + GAP
			puts START_INDICATION + "Here is your account information." + GAP
			puts START_INDICATION + "Don't lose it :)" + GAP
			puts END_SECTION
			quit
		elsif selected == "2" && reply == "qwe@gmail.com"
			puts START_INDICATION + "Found it!" + GAP
			puts START_INDICATION + "Here is your account information." + GAP
			puts START_INDICATION + "Don't lose it :)" + GAP
			puts END_SECTION
			quit
		else
			puts START_INDICATION + "Sorry, I don't see you in the database" + GAP
			question_1 = START_INDICATION + "Should we move on?" + GAP
			opts_1 = " [1]Call for help [2]Create account [3]Login as guest "
			opts_arr_1 = ["1", "2", "3"]
			selected_1 = offer_options(question_1, opts_1, opts_arr_1)

			if selected_1 == "1"
				login_rescue
			elsif selected_1 == "2"
				puts END_SECTION
				login_create_user
			elsif selected_1 == "3"
				puts END_SECTION
				@username = "Guest"
				home_page
			else
				puts "ERROR!!!"
			end
		end
	end

	def login_create_user

		puts START_SECTION
		puts START_INDICATION + "is0xNextToDo welcomes you!" + GAP
		puts START_INDICATION + "Enter your new username." + GAP
		username = puts_promot

		while username == "asd"
			puts START_INDICATION + "Sorry, the username has been used." + GAP
			puts START_INDICATION + "Pick another one." + GAP
			username = puts_promot
		end

		email_validate = false
		puts START_INDICATION + "Enter your email." + GAP
		while !email_validate
			email = puts_promot

			if !is_valid_email?email
				puts START_INDICATION + "The email is not valid. Please check it again." + GAP
			else
				email_validate = true
			end
		end

		password_validate = false
		puts START_INDICATION + "Make a password." + GAP
		while !password_validate
			print "[#{@username}]: "
			password = STDIN.noecho(&:gets).chomp
			puts GAP
			puts START_INDICATION + "Enter your password again." + GAP
			print "[#{@username}]: "
			password_1 = STDIN.noecho(&:gets).chomp
			puts GAP
			
			if password == password_1
				password_validate = true
			else
				puts START_INDICATION + "The entered passwords don't match." + GAP
				puts START_INDICATION + "Please type it in again." + GAP
				password_validate = false
			end
		end

		# create account
		puts START_INDICATION + "Your account has been created." + GAP
		puts START_INDICATION + "Here is your account information." + GAP
		# account info table
		# set @username
		puts START_INDICATION + "Thank you for join is0xNextToDo." + GAP
		puts END_SECTION
		puts home_page
	end

	def login_member

		if !@login_failed
			puts START_INDICATION + "Great! Tell me your username." + GAP
		else
			puts START_INDICATION + "I love you attitude. Let's try again" + GAP
			puts START_INDICATION + "Your username, please." + GAP
		end

		username = puts_promot
		puts START_INDICATION + "And password. Don't worry, I won't tell anyone :)" + GAP
		print "[#{@username}]: "
		password = STDIN.noecho(&:gets).chomp
		puts GAP

		if username == "asd" && password == "asd"
			@username = "Yun-Chi"
			@login_failed = false
			puts END_SECTION
			home_page
		else
			@login_failed = true
			puts START_INDICATION + "Seems like your username or password is wrong" + GAP
			puts START_INDICATION + "Calm down buddy. I will help you out." + GAP

			question = START_INDICATION + "Pick one." + GAP
			opts = " [1]Try again [2]Need a rescue team [3]Login as guest "
			opts_arr = ["1", "2", "3"]
			selected = offer_options(question, opts, opts_arr)

			if selected == "1"
				login_member
			elsif selected == "2"
				login_rescue
			elsif selected == "3"
				@username = "Guest"
				puts END_SECTION
				home_page
			else
				puts "ERROR!!!"
			end
		end
	end

	def home_page
		
		puts START_SECTION
		puts "$$$ Home $$$" + GAP
		
		if !@home_page_visited
			question = START_INDICATION + "It's you #{username}! How can I help you?" + GAP
			@home_page_visited = true
		else 
			question = nil
		end

		opts = " [1]Surprise [2]Advanced [3]Collection [4]Quit "
		opts_arr = ["1", "2", "3", "4"]
		selected = offer_options(question, opts, opts_arr)

		puts END_SECTION

		if selected == "1"
			surprise
		elsif selected == "2"
			advanced
		elsif selected == "3"
			collection
		elsif selected == "4"
			quit
		else
			puts "ERROR!!!"
		end
	end

	def surprise

		puts START_SECTION
		puts "$$$ Suprise $$$" + GAP
		puts "COOOOOOOOOOOOOL" + GAP

		question =  START_INDICATION + "Here you go! What to do next?" + GAP
		opts = " [1]Next [2]Save it [3]Home "
		opts_arr = ["1", "2", "3"]
		selected = offer_options(question, opts, opts_arr)
	
		if selected == "1"
			puts END_SECTION
			surprise
		elsif selected == "2"
			puts START_INDICATION + "It's has been save to your collection"
			puts END_SECTION
			home_page
		elsif selected == "3"
			puts END_SECTION
			home_page
		else 
			puts "Error!!!"
		end
	end

	def advanced
		
		puts START_SECTION
		puts "$$$ Advanced $$$" + GAP
		
		question = "Type?"
		opts = " [1]Education [2]Recreational [3]Social [4]Charity [5]Cooking [6]Relaxation [7]Music [8]Busywork "
		opts_arr = ["1", "2", "3", "4", "5", "6", "7", "8"]
		type = offer_options(question, opts, opts_arr)

		puts "[is0]: Accessibility? (Easy->Hard = 0->1)" + GAP
		accessibility = puts_promot
		puts "[is0]: Price? (Free->Paid = 0->1)" + GAP
		price = puts_promot
		puts "[is0]: Participants? (0->N)" + GAP
		participants = puts_promot
	end

	def collection
	end

	def quit
		setup
		start
	end

	def leave
		puts File.readlines('./resources/bye.txt')
		puts
		puts "======Developed by is0xjh25 - Supported by Bored-API======"
		puts
		exit
	end

	# Helper Functions
	def puts_options(text)
		print VER
		text.each_char {|char| print HOR}
		print VER
		puts
		puts VER + text + VER
		print VER
		text.each_char {|char| print HOR}
		print VER
		puts
		puts
	end

	def puts_promot
		print "[#{@username}]: "
		input = gets.strip.downcase
		puts
		input
	end

	def offer_options(question, opts, opts_arr)
		
		puts question
		puts_options(opts) 
		selected = puts_promot

		while !opts_arr.include? selected 
			puts START_INDICATION + "Please enter a valid number!" + GAP
			selected = puts_promot
		end

		selected
	end

	def is_valid_email?(email)
		email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end
  
end