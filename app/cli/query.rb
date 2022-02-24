module CLI
	
	def surprise

		puts CLI::make_title("Surprise") + GAP_LINE
		# activity format
		puts "COOOOOOOOOOOOOL" + GAP_LINE

		question =  START + "Here you go! What to do next?" + GAP_LINE
	
		options = {
			"1" => {label: "NEXT", method: "surprise"},
			"2" => {label: "SAVE", method: ""},
			HOME => {label: "HOME", method: "home"},
		}
		CLI::make_options(question, options)
	end

	def surprise_guest

		puts CLI::make_title("Surprise") + GAP_LINE
		# activity format
		puts "COOOOOOOOOOOOOL" + GAP_LINE

		question =  START + "Here you go! What to do next?" + GAP_LINE	
		options = {
			"1" => {label: "NEXT", method: "surprise"},
			HOME => {label: "HOME", method: "home_guest"},
		}
		CLI::make_options(question, options)
	end

	def advanced
		
		puts CLI::make_title("Advanced") + GAP_LINE
		question =  START + "Choose a filter." + GAP_LINE	
		options = {
			"1" => {label: "TYPE", method: nil},
			"2" => {label: "PRICE", method: nil},
			"3" => {label: "ACCESSLEVEL", method: nil},
			"4" => {label: "PARTICIPANT", method: nil},
		}
		filter = CLI::make_options(question, options)
		
		if filter == "1"
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
			selected = CLI::make_options(question, options)
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

		# data
		# handle no data
	end

	def advanced_guest
	end

	module_function :surprise, :surprise_guest, :advanced, :advanced_guest
end