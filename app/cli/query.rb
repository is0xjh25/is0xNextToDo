module CLI
	
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
end