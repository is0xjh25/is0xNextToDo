module NextToDo
		
	def make_title(text)
		
		symbol_length = (DIVIDER_LENGTH - text.size) / 2 - EMPHASIZE_SYMBOL_F.size
		str = DIVIDER_SYMBOL * symbol_length + EMPHASIZE_SYMBOL_F

		if text.size % 2 == 1
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * (symbol_length + 1)
		else
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * symbol_length
		end
		
		return str
	end
	
	# support reading sinlge input and control-c command
	def get_char
		state = `stty -g`
		`stty raw -echo -icanon isig`
		STDIN.getc.chr
		ensure
		`stty #{state}`
	end

	# create options 
	def puts_options(options)
				
		content_length = DIVIDER_LENGTH
		line = ""

		if [2, 3, 4].include?(options.size)
			option_length = content_length / options.size
			options.each do |key, info|
				label = info[:label]
				# 1  WhiteSpace + [1] + 1 WhiteSpace + START + the rest of gap
				overall_length = 3 + key.size + label.size
				if option_length >= overall_length
					line += "[#{key.upcase}]" + "#{label}" + WHITE_SPACE * (option_length - overall_length + 1)
				else
					begin
						raise NextToDoError
					rescue NextToDoError => error
						puts error.option_too_long
						home
					end
				end  
			end

			# option box
			puts HOR * DIVIDER_LENGTH
			puts line
			puts HOR * DIVIDER_LENGTH
			puts
		elsif [6, 7, 8].include?(options.size)
			split_options = options.dup
			split_options_1 = {}
			(options.size / 2).times do
				key, value = split_options.shift
				split_options_1.merge!("#{key}" => value)
			end
			puts_options(split_options_1)
			puts_options(split_options)
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.options_overload
				home
			end
		end
	end

	# create options functionality
	def make_options(question: question, opt: options)
		
		warning_count = 0
		puts question
		puts_options(opt)
		input = puts_short_promot

		while !opt.has_key?(input)
			if warning_count > MAX_INPUT_ATTEMPT
				begin
					raise NextToDoError
				rescue NextToDoError => error
					puts error.excessive_warning
					quit
				end
			end
			puts START_WARNING + "Please enter a valid CHARACTER or NUMBER." + GAP_LINE
			input = puts_short_promot
			warning_count += 1
		end

		if opt[input][:method]
			if opt[input][:argument]
				self.send(opt[input][:method], opt[input][:argument])
			else
				self.send(opt[input][:method])
			end
		else
			return input
		end
	end

	def puts_short_promot
		print "[#{NextToDo::username.capitalize}]: "
		input = get_char.upcase
		print input + GAP_LINE
		return input
	end

	def puts_long_promot
		print "[#{NextToDo::username.capitalize}]: "
		input = gets.strip.downcase
		puts
		return input
	end

	def valid_email?(email)
		return email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end

	module_function :make_title, :get_char, :puts_options, :make_options, :puts_short_promot, :puts_long_promot, :valid_email?
end