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
	
	# support reading sinlge input and control-c command
	def get_char
		state = `stty -g`
		`stty raw -echo -icanon isig`
		STDIN.getc.chr
		ensure
		`stty #{state}`
	end

	def puts_options(options)
				
		content_length = DIVIDER_LENGTH
		line = ""

		if [2, 3, 4].include? options.size
			option_length = content_length / options.size
			options.each do |key, info|
				label = info[:label]
				# 1  WhiteSpace + [1] + 1 WhiteSpace + START + the rest of gap
				overall_length = 3 + key.size + label.size
				if option_length >= overall_length
					line += "[#{key.upcase}]" + "#{label}" + WHITE_SPACE * (option_length - overall_length + 1)
				else
					begin
						raise CliError
					rescue CliError => error
						puts error.option_too_long
					end
				end  
			end

			# option box
			puts HOR * DIVIDER_LENGTH
			puts line
			puts HOR * DIVIDER_LENGTH
			puts
		elsif [6, 7, 8].include? options.size
			split_options = options.dup
			split_options_1 = {}
			(options.size / 2).times do
				key, value = split_options.shift
				split_options_1.merge!("#{key}" => value)
			end
			CLI::puts_options(split_options_1)
			CLI::puts_options(split_options)
		else
			begin
				raise CliError
			rescue CliError => error
				puts error.options_overload
			end
		end
	end

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

		if options[input][:method]
			self.send(options[input][:method])
		else
			input
		end
	end

	def puts_short_promot
		print "[#{CLI::username}]: "
		input = get_char.downcase
		print input + GAP_LINE
		input
	end

	def puts_long_promot
		print "[#{CLI::username}]: "
		input = gets.strip.downcase
		puts
		input
	end

	def valid_email?(email)
		email =~ /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	end

	module_function :make_title, :get_char, :puts_options, :make_options, :puts_short_promot, :puts_long_promot, :valid_email?
end