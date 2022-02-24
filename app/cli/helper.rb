module CLI
		
	def make_title(text)
		
		symbol_length = (DIVIDER_LENGTH - text.size) / 2 - EMPHASIZE_SYMBOL_F.size
		str = DIVIDER_SYMBOL * symbol_length + EMPHASIZE_SYMBOL_F

		if text.size % 2 == 1
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * (symbol_length + 1)
		else
			str += text + EMPHASIZE_SYMBOL_E + DIVIDER_SYMBOL * symbol_length
		end
		
		str
	end
	module_function :make_title
	
	# support reading sinlge input and control-c command
	def get_char
		state = `stty -g`
		`stty raw -echo -icanon isig`
		STDIN.getc.chr
		ensure
		`stty #{state}`
	end
	module_function :get_char

	def puts_options(options)
				
		content_length = DIVIDER_LENGTH
		line = ""

		if [2, 3, 4].include? options.size
			option_length = content_length / options.size
			options.each do |key, info|
				label = info[:label]
				# 1  WhiteSpace + [1] + 1 WhiteSpace + START + the rest of gap
				overall_length = 4 + key.size + label.size
				if option_length >= overall_length
					line += WHITE_SPACE + "[#{key.upcase}]" + WHITE_SPACE + "#{label}" + WHITE_SPACE * (option_length - overall_length + 1)
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
	module_function :puts_options

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
					CLI::quit
				end
			end
			puts START_WARNING + "Please enter a valid CHARACTER or NUMBER." + GAP_LINE
			input = puts_short_promot
			warning_count += 1
		end

		self.send(options[input][:method])
	end
	module_function :make_options

	def puts_short_promot
		print "[#{CLI::username}]: "
		input = get_char.downcase
		print input + GAP_LINE
		input
	end
	module_function :puts_short_promot

	def puts_long_promot
		print "[#{CLI.username}]: "
		input = get_strip.downcase
		print input + GAP_LINE
		input
	end
	module_function :puts_long_promot

	def valid_email?(email)
		email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end
	module_function :valid_email?
end