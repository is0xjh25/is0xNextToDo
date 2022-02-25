module CLI

	def handle_query(user: "guest", type: "surprise")

		question =  START + "Here you go! What to do next?" + GAP_LINE

		if user == "member" && type == "surprise"
			options = {
				NEXT => {label: "NEXT", method: "surprise", argument: user},
				SAVE => {label: "SAVE", method: ""},
				HOME => {label: "HOME", method: "home", argument: user},
			}
		elsif user == "guest" && type == "surprise"
			options = {
				NEXT=> {label: "NEXT", method: "surprise", argument: user},
				HOME => {label: "HOME", method: "home", argument: user},
			}
		elsif user == "member" && type == "advanced"
			options = {
				NEXT => {label: "NEXT", method: ""},
				SAVE => {label: "SAVE", method: ""},
				RESET => {label: "RESET", method: "advanced", argument: user},
				HOME => {label: "HOME", method: "home", argument: user},
			}
		elsif user == "guest" && type == "advanced"
			options = {
				NEXT => {label: "NEXT", method: ""},
				RESET => {label: "RESET", method: "advanced", argument: user},
				HOME => {label: "HOME", method: "home", argument: user},
			}
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.invalid_argument
			end
		end

		CLI::make_options(question: question, opt: options)
	end

	
	def surprise(user)

		puts CLI::make_title("Surprise") + GAP_LINE
		# show data
		# handle no data
		CLI::puts_activity()

		if user == "guest" || user == "member"
			CLI::handle_query(user: user, type: "surprise")
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.invalid_argument
			end
		end
	end

	def advanced(user)
		
		puts CLI::make_title("Advanced") + GAP_LINE
		question =  START + "Choose a filter." + GAP_LINE	
		options = {
			"1" => {label: "TYPE", method: nil},
			"2" => {label: "PRICE", method: nil},
			"3" => {label: "ACCESSLEVEL", method: nil},
			"4" => {label: "PARTICIPANT", method: nil},
		}
		filter = CLI::make_options(question: question, opt: options)
		
		if filter == "1"
			question = START + "Choose a type." + GAP_LINE	
			options = {
				"1" => {label: "EDUCATION", method: nil},
				"2" => {label: "RECREATION", method: nil},
				"3" => {label: "SOCIAL", method: nil},
				"4" => {label: "CHARITY", method: nil},
				"5" => {label: "COOKING", method: nil},
				"6" => {label: "RELAXTION", method: nil},
				"7" => {label: "MUSIC", method: nil},
				"8" => {label: "BUYSWORK", method: nil},
			}
			selected = CLI::make_options(question: question, opt: options)
		elsif filter == "2"
			puts "[is0]: Price? (Free->Paid = 0->1)" + GAP_LINE
			selected  = puts_long_promot
		elsif filter == "3"
			puts "[is0]: Accessibility? (Easy->Hard = 0->1)" + GAP_LINE
			selected  = puts_long_promot
		elsif filter == "4"
			puts "[is0]: Participants? (0->N)" + GAP_LINE
			selected  = puts_long_promot
		end

		# show data
		# handle no data
		puts "COOOOOOOOOOOOOL" + GAP_LINE
		CLI::handle_query(user: "member", type: "advanced", user: user)
	end

	def puts_activity()
		
		# example
		eg = {
			"activity": "Learn a new programming language",
			"accessibility": 0.25,
			"type": "education",
			"participants": 1,
			"price": 0.1,
			"key": "5881028"
		}

		col_name = ["activity", "type", "participants", "accessibility", "price"]
		col_max_length = col_name.max_by(&:length).size + 2

		col_name.each do |e|
			puts BORDER * col_max_length
			puts VER + "#{e.capitalize}" + WHITE_SPACE * (col_max_length - e.size - 2) + VER + WHITE_SPACE + eg[:"#{e}"].to_s.capitalize
		end
		puts BORDER * col_max_length + GAP_LINE
	end

	module_function :handle_query, :surprise, :advanced, :puts_activity
end