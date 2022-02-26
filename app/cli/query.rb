module CLI

	def handle_query(user:, type:)

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
				NEXT => {label: "NEXT", method: "advanced", argument: user},
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

	# guest and member can access
	def surprise(user)

		puts CLI::make_title("Surprise") + GAP_LINE
		
		response = ApiHelper::get_random
		if response[:status] == "success"
			CLI::puts_activity(response[:info])
		elsif response[:status] == "warning"
			puts START_WARNING + response[:info] + "." + GAP_LINE
			CLI::home(user)
		elsif response[:status] == "error"
			puts START_ERROR + response[:info] + "." + GAP_LINE
			CLI::home(user)
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.key_not_found
			end
		end

		# following actions
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

	# guest and member can access
	def advanced(user)
		
		categories = ["type", "participant", "accessibility", "price"]
		puts CLI::make_title("Advanced") + GAP_LINE
		question =  START + "Choose a filter." + GAP_LINE	
		options = {
			"1" => {label: categories[0].upcase, method: nil},
			"2" => {label: categories[1].upcase, method: nil},
			"3" => {label: "ACCESSLEVEL", method: nil},
			"4" => {label: categories[3].upcase, method: nil},
		}
		filter = CLI::make_options(question: question, opt: options)
		
		if filter == "1"
			types = ["education", "recreational", "social", "diy", "charity", "cooking", "relaxation", "music", "busywork"]
			question = START + "Choose a type." + GAP_LINE	
			options = {
				"1" => {label: types[0].upcase, method: nil},
				"2" => {label: "RECREATION", method: nil},
				"3" => {label: types[2].upcase, method: nil},
				"4" => {label: types[3].upcase, method: nil},
				"5" => {label: types[4].upcase, method: nil},
				"6" => {label: types[5].upcase, method: nil},
				"7" => {label: types[6].upcase, method: nil},
				"8" => {label: types[7].upcase, method: nil},
			}
			value = CLI::make_options(question: question, opt: options)
			value = types[value.to_i]
		elsif filter == "2"
			puts "[is0]: Participants? (0->N)" + GAP_LINE
			value  = puts_long_promot
		elsif filter == "3"
			puts "[is0]: Accessibility? (Easy->Hard = 0->1)" + GAP_LINE
			value  = puts_long_promot
		elsif filter == "4"
			puts "[is0]: Price? (Free->Paid = 0->1)" + GAP_LINE
			value  = puts_long_promot
		end

		response = ApiHelper::get_advanced(opt: categories[filter.to_i], val:value.to_s)
		if response[:status] == "success"
			CLI::puts_activity(response[:info])
		elsif response[:status] == "warning"
			puts START_WARNING + response[:info] + "." + GAP_LINE
			CLI::home(user)
		elsif response[:status] == "error"
			puts START_ERROR + response[:info] + "." + GAP_LINE
			CLI::home(user)
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.key_not_found
			end
		end

		# following actions
		if user == "guest" || user == "member"
			CLI::handle_query(user: user, type: "advanced")
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.invalid_argument
			end
		end
	end

	# member access only
	def collection
	end

	# print out activit table
	def puts_activity(info)
		
		# main categories
		col_name = ["activity", "type", "participants", "accessibility", "price"]
		col_max_length = col_name.max_by(&:length).size + 2

		col_name.each do |e|
			puts BORDER * col_max_length
			puts VER + "#{e.capitalize}" + WHITE_SPACE * (col_max_length - e.size - 2) + VER + WHITE_SPACE + info["#{e}"].to_s.capitalize
		end
		puts BORDER * col_max_length + GAP_LINE
	end

	module_function :handle_query, :surprise, :advanced, :puts_activity
end