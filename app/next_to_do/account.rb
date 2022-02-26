module NextToDo

	# guest and member can access
	def login

		puts make_title("Login") + GAP_LINE

		# options
		question = START + "Do you have an account already?" + GAP_LINE
		options = {
			"1" => {label: "GOT ONE", method: "member"},
			"2" => {label: "CREATE ONE", method: "create_account"},
			"3" => {label: "BE GUEST", method: "home"},
			MENU => {label: "MENU", method: "menu"}
		}
		make_options(question: question, opt: options)
	end

	# guest and member can access
	def member
		
		if !login_failed
			puts START + "Great! Tell me your username." + GAP_LINE
		elsif login_failed && login_attempt > MAX_LOGIN_ATTEMPT
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.excessive_login_attempt
				quit
			end
		else
			puts START + "I love you attitude. Let's try again" + GAP_LINE
			puts START + "Your username, please." + GAP_LINE
		end

		username = puts_long_promot
		puts START + "And password. Don't worry, I won't tell anyone :)" + GAP_LINE
		print "[#{NextToDo::username}]: "
		password = STDIN.noecho(&:gets).chomp
		puts GAP_LINE

		# success or fail
		if username == "asd" && password == "asd"
			NextToDo::username = "Yun-Chi"
			login_failed = false
			login_attempt = 0
			home
		else
			login_failed = true
			login_attempt += 1
			puts START_WARNING + "The email or password is incorrect." + GAP_LINE
			puts START + "Calm down buddy. I will help you out." + GAP_LINE
			# options
			question = START + "Pick one." + GAP_LINE
			options = {
				"1" => {label: "TRY AGAIN", method: "member"},
				"2" => {label: "RESCUE", method: "rescue"},
				"3" => {label: "BE GUEST", method: "home"},
				MENU => {label: "MENU", method: "menu"}
			}
			make_options(question: question, opt: options)
		end
	end

	# guest access only
	def create_account

		puts make_title("Create Account") + GAP_LINE
		puts START + "is0xNextToDo welcomes you!" + GAP_LINE
		
		# username
		puts START + "Enter your new username." + GAP_LINE
		username = puts_long_promot
		while username == "asd" || username.downcase == DEFAULT_USER.downcase
			puts START_WARNING + "The username has been used." + GAP_LINE
			puts START + "Pick another one." + GAP_LINE
			username = puts_long_promot
		end

		# email
		puts START + "Enter your email." + GAP_LINE
		email_validate = false
		while !email_validate
			
			email = puts_long_promot

			if !valid_email?(email)
				puts START_WARNING + "The email is not valid. Please check it again." + GAP_LINE
			else
				email_validate = true
			end
		end

		while email == "asd@gmail.com"
			puts START_WARNING + "The email has been used." + GAP_LINE
			puts START + "Try another one." + GAP_LINE
			email = puts_long_promot
		end

		# password
		password = set_password

		# create account
		puts START + "Your account has been created." + GAP_LINE
		puts START + "Here is your account information." + GAP_LINE
		# display account info
		puts_account
		puts START + "Thank you for join is0xNextToDo." + GAP_LINE
		
		# set user
		NextToDo::username = username 
		home
	end

	# guest access only
	def rescue

		puts make_title("Rescue Account") + GAP_LINE
		puts START + "The rescue team is here!" + GAP_LINE

		question = START + "Give me some information about you." + GAP_LINE
		options = {
			"1" => {label: "USERNAME", method: nil},
			"2" => {label: "EMAIL", method: nil},
		}
		selected = make_options(q: question, opt: options)

		puts START + "I'm listening."+ GAP_LINE
		
		input = puts_long_promot

		if selected = "1" && input == "qwe"
			puts START + "Found it!" + GAP_LINE
			puts START + "Here is your account information." + GAP_LINE
			puts START + "Don't lose it :)" + GAP_LINE
			question = START + "Want to reset password?." + GAP_LINE
			options = {
				"1" => {label: "LET'S GO", method: nil},
				"2" => {label: "ALL GOOD", method: nil},
			}
			selected_1 = make_options(question: question, opt: options)
			
			if selected_1 == "1"
				password = set_password
				#update password
				puts START + "Your password has been update." + GAP_LINE
				puts START + "Here is your account information." + GAP_LINE
				# display account info
				puts_account
				login
			elsif selected_1 == "2"
				puts START + "Here is your account information." + GAP_LINE
				# display account info
				puts_account
				# set user
				NextToDo::username = username
				home
			end
		elsif rescue_attempt > MAX_RESCUE_ATTEMPT
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.excessive_rescue_attempt
				quit
			end
		else
			rescue_attempt += 1
			puts START + "Sorry, I don't see you in the database" + GAP_LINE
			question = START + "Should we move on?" + GAP_LINE
			options = {
				"1" => {label: "RESCUE", method: "rescue"},
				"2" => {label: "CREATE ONE", method: "create_account"},
				"3" => {label: "BE GUEST", method: "home"},
			}
			make_options(question: question, opt: options)
		end
	end

	def set_password
		
		puts START + "Make a password." + GAP_LINE
		password_validate = false
		while !password_validate
			print "[#{NextToDo::username}]: "
			password = STDIN.noecho(&:gets).chomp
			puts GAP_LINE
			puts START + "Enter your password again." + GAP_LINE
			print "[#{NextToDo::username}]: "
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

		# update password
		password
	end

	# print out account information table
	def puts_account()
		# example
		info = {
			"username": "is0xjh25",
			"password": "12345678",
			"email": "qyf@gmail.com",
		}

		col_name = ["username", "password", "email"]
		col_max_length = col_name.max_by(&:length).size + 2

		col_name.each do |e|
			puts BORDER * col_max_length
			puts VER + "#{e.capitalize}" + WHITE_SPACE * (col_max_length - e.size - 2) + VER + WHITE_SPACE + info[:"#{e}"]
		end
		puts BORDER * col_max_length + GAP_LINE
	end
	
	module_function :login, :member, :create_account, :rescue, :set_password, :puts_account
end