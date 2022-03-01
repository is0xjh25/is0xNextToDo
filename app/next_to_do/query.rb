module NextToDo

	# guest and member can access
	def surprise

		puts make_title("New Activity") + GAP_LINE
		
		response = ApiHelper::get_random
		if response[:status] == "success"
			# update key's name
			response[:info]["category"] = response[:info].delete("type")
			puts_activity(response[:info])
		elsif response[:status] == "warning"
			puts START_WARNING + response[:info] + "." + GAP_LINE
			home
		elsif response[:status] == "error"
			puts START_ERROR + response[:info] + "." + GAP_LINE
			home
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.key_not_found
				home
			end
		end

		# following actions
		response[:type] = "surprise"
		response[:preference] = nil
		handle_query(response)
	end

	# guest and member can access
	def advanced(preference=nil)
	
		puts make_title("Advanced") + GAP_LINE
		
		if preference == nil
			
			categories = ["category", "participants", "accessibility", "price"]
			question =  START + "Choose a filter." + GAP_LINE	
			options = {
				"1" => {label: categories[0].upcase, method: nil},
				"2" => {label: "PARTICIPANT", method: nil},
				"3" => {label: "ACCESSLEVEL", method: nil},
				"4" => {label: categories[3].upcase, method: nil},
			}
			filter = make_options(question: question, opt: options)
			
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
				value = make_options(question: question, opt: options)
				value = types[value.to_i-1]
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
			
			preference = {opt: categories[filter.to_i-1], val: value.to_s}
		end

		response = ApiHelper::get_advanced(opt: preference[:opt], val:preference[:val])
		puts make_title("New Activity") + GAP_LINE
		if response[:status] == "success"
			# update key's name
			response[:info]["category"] = response[:info].delete("type")
			puts_activity(response[:info])
		elsif response[:status] == "warning"
			puts START_WARNING + response[:info] + "." + GAP_LINE
			puts START + "Please try again!" + GAP_LINE
			advanced
		elsif response[:status] == "error"
			puts START_ERROR + response[:info] + "." + GAP_LINE
			puts START + "Please try again!" + GAP_LINE
			advanced
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.key_not_found
				home
			end
		end

		# following actions
		response[:type] = "advanced"
		response[:preference] = preference
		handle_query(response)
	end

	# member access only
	def collection(ask={sorted: "participants", ordered: "asc"})

		categories = ["category", "participants", "accessibility", "price"]
		orders = ["asc", "desc"]
		
		if ask == "reset"
			
			question =  START + "Sorted by?" + GAP_LINE	
			options = {
				"1" => {label: categories[0].upcase, method: nil},
				"2" => {label: "PARTICIPANT", method: nil},
				"3" => {label: "ACCESSLEVEL", method: nil},
				"4" => {label: categories[3].upcase, method: nil},
			}
			sorted = make_options(question: question, opt: options)

			question =  START + "Ordered by?" + GAP_LINE	
			options = {
				"1" => {label: orders[0].upcase, method: nil},
				"2" => {label: orders[1].upcase, method: nil},
			}
			ordered = make_options(question: question, opt: options)

			# Sorted order
			ask = {sorted: categories[sorted.to_i-1], ordered: orders[ordered.to_i-1]}
			collection(ask)
		elsif categories.include?(ask[:sorted]) && orders.include?(ask[:ordered])
			data = User.find_by(username: NextToDo::username).show_collection(sort: ask[:sorted], order: ask[:ordered])
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.key_not_found
				home
			end
		end

		puts make_title(NextToDo::username.capitalize + "'s" + WHITE_SPACE + "Collection") + GAP_LINE
		puts_collection(data)

		if data.empty?
			options = {
				"1" => {label: "SURPRISE", method: "surprise"},
				"2" => {label: "ADVANCED", method: "advanced"},
				MENU => {label: "MENU", method: "menu"}
			}
			action = make_options(question: nil, opt: options)
		else
			options = {
				"1" => {label: "RANDOM", method: nil},
				"2" => {label: "PICK", method: nil},
				"3" => {label: "SORTED BY", method: "collection", argument: "reset"},
				HOME => {label: "HOME", method: "home"},
			}
			action = make_options(question: nil, opt: options)
		end


		# random
		if action == "1"
			# following actions
			info = data[rand(data.size).to_i]
			response = {type: "collection", info: info}
			puts make_title("Saved Activity") + GAP_LINE
			puts_activity(info)
			handle_query(response)
		# pick
		elsif action == "2"

			attempt = 0
			picked = -1
			puts START + "Enter the number." + GAP_LINE
			
			while !picked.between?(0, data.size-1)
				
				picked = puts_long_promot.to_i-1
				attempt += 1
				if attempt > 1
					puts START + "Please enter a valid NUMBER." + GAP_LINE
				end

				if attempt > MAX_INPUT_ATTEMPT
					begin
						raise NextToDoError
					rescue NextToDoError => error
						puts error.excessive_warning
						quit
					end
				end
			end

			info = data[picked]
			response = {type: "collection", info: info}
			puts make_title("Saved Activity") + GAP_LINE
			puts_activity(info)
			handle_query(response)
		end
	end

	def handle_query(response)

		# surprise handler
		if NextToDo::username == DEFAULT_USER && response[:type] == "surprise"
			options = {
				NEXT => {label: "NEXT", method: "surprise"},
				HOME => {label: "HOME", method: "home"}
			}
		elsif response[:type] == "surprise"
			options = {
				NEXT => {label: "NEXT", method: "surprise"},
				SAVE => {label: "SAVE", method: "save_activity", argument: response},
				HOME => {label: "HOME", method: "home"}
			}
		# advanced handler
		elsif NextToDo::username == DEFAULT_USER && response[:type] == "advanced"
			options = {
				NEXT => {label: "NEXT", method: "advanced", argument: response[:preference]},
				RESET => {label: "RESET", method: "advanced"},
				HOME => {label: "HOME", method: "home"}
			}
		elsif response[:type] == "advanced"
			options = {
				NEXT => {label: "NEXT", method: "advanced", argument: response[:preference]},
				SAVE => {label: "SAVE", method: "save_activity", argument: response},
				RESET => {label: "RESET", method: "advanced"},
				HOME => {label: "HOME", method: "home"}
			}
		# collection handler
		elsif response[:type] == "collection"
			options = {
				"1" => {label: "UNSAVE", method: "unsave_activity", argument: response},
				"2" => {label: "COLLECTION", method: "collection"},
			}
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.invalid_argument
				home
			end
		end

		make_options(question: nil, opt: options)
	end

	# member access only
	# save activity into collection
	def save_activity(response)

		### save function
		User.find_by(username: NextToDo::username).collection_save(info: response[:info])
		
		question =  START + "The activity has been saved to your collection." + GAP_LINE

		if response[:type] == "surprise"
			options = {
				NEXT => {label: "NEXT", method: "surprise"},
				HOME => {label: "HOME", method: "home"},
				"3" => {label: "COLLECTION", method: "collection"},
			}
		elsif response[:type] == "advanced"
			options = {
				NEXT => {label: "NEXT", method: "advanced", argument: response[:preference]},
				RESET => {label: "RESET", method: "advanced"},
				HOME => {label: "HOME", method: "home"},
				"4" => {label: "COLLECTION", method: "collection"},
			}
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.key_not_found
				home
			end
		end

		make_options(question: question, opt: options)
	end

	# member access only
	# remove activity from collection
	def unsave_activity(response)
		
		question = START + "Are you sure want to remove it from your collection?" + GAP_LINE
		options = {
			NO => {label: "NO", method: nil},
			YES => {label: "YES", method: nil},
		}
		confirm = make_options(question: question, opt: options)

		if confirm == NO
			puts_activity(response[:info])
			handle_query(response)
		elsif confirm == YES
			User.find_by(username: NextToDo::username).collection_remove(info: response[:info])
			puts START + "The activity has been removed" + GAP_LINE
			collection
		end
	end

	# print out activity table
	def puts_activity(info)

		info = info.transform_keys(&:to_s)
		# main categories
		col_name = ["activity", "category", "participants", "accessibility", "price"]
		col_max_length = col_name.max_by(&:length).size + 2

		col_name.each do |e|
			puts BORDER * col_max_length
			puts VER + "#{e.capitalize}" + WHITE_SPACE * (col_max_length - e.size - 2) + VER + WHITE_SPACE + info["#{e}"].to_s.capitalize
		end

		puts BORDER * col_max_length
	end

	# print out collection table
	def puts_collection(data)
		
		puts BORDER * DIVIDER_LENGTH
		puts VER + WHITE_SPACE + "#" + WHITE_SPACE + VER + WHITE_SPACE + "Activity" + WHITE_SPACE * (DIVIDER_LENGTH - 15) + VER

		data.each_with_index do |v, i|
			puts BORDER * DIVIDER_LENGTH
			puts VER + WHITE_SPACE * (3 - (i+1).to_s.size) + (i+1).to_s + VER + WHITE_SPACE + v[:activity] + WHITE_SPACE * (DIVIDER_LENGTH - v[:activity].size - 7) + VER
		end

		puts BORDER * DIVIDER_LENGTH
	end

	module_function :surprise, :advanced, :collection, :handle_query, :save_activity, :unsave_activity, :puts_activity, :puts_collection
end