module CLI

	def login

		puts CLI::make_title("Login") + GAP_LINE

		# options
		question = START + "Do you have an account already?" + GAP_LINE
		options = {
			"1" => {label: "LOGIN", method: "CLI::login_member"},
			"2" => {label: "CREATE ONE", method: "CLI::login_create_account"},
			"3" => {label: "BE GUEST", method: "home_page"}
		}

		CLI::make_options(question, options)
	end
	module_function :login

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
	module_function :login_member


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
	module_function :login_create_account

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
	module_function :login_rescue
end