class Cli

	GAP = "\n\n"
	DIVIDER = "=========================================="
	OPTION = "******************************************"

	INITIAL_USER = "Guest"
	attr_accessor :username, :home_page_visited

	def initialize()
		@username = INITIAL_USER
		@home_page_visited = false
	end

	def call
	#   start
		puts File.readlines('favicon.txt')
		puts
		puts DIVIDER
		puts "Welcome to NextToDo!" + GAP
		puts "Are you bored? Let's get some funs!"
		puts DIVIDER
		self.start
	end

	def start
		puts "[is0]: Do you have an account already? Enter Y or N" + GAP
		print "[#{username}]: "
		input = gets.strip.downcase
		if input == "y"
			puts
			self.login
		elsif input == "n"
		  	puts
		  	puts "Wanna create one"
		else
			puts
		  	puts "[is0]: Oops...I don't understand that answer."
		  	puts DIVIDER
		  	self.start
		end

	end

	def login
		puts "[is0]: Great! Tell me your username." + GAP
		print "[#{username}]: "
		username = gets.strip.downcase
		puts
		puts "[is0]: And password. Don't worry, I won't tell anyone :)" + GAP
		print "[#{username}]: "
		password = STDIN.noecho(&:gets).chomp
		puts

		if username == "asd" && password == "asd"
			@username = "Yun-Chi"
			puts
			self.home_page
		else
			puts "[is0]: Seems like your username or password is wrong" + GAP
		end
	end

	def home_page
		if !@home_page_visited
			puts "[is0]: It's you #{username}! How can I help you?" + GAP
			@home_page_visited = true
		end
		puts OPTION
		puts "[1]Surprise [2]Advanced [3]Collection [4]Quit"
		puts OPTION + GAP
		print "[#{username}]: "
		input = gets.strip
		puts
		if input == "1"
			puts DIVIDER
			self.surprise
		elsif input == "2"
		  	puts DIVIDER
			self.advanced
		elsif input == "3"
			puts DIVIDER
			self.collection
		elsif input == "4"
			puts DIVIDER
			self.quit
		else
			puts "[is0]: Please enter a valid number!"
			puts
			self.home_page 
		end
	end

	def create_user
	end

	def surprise
	end

	def advanced
	end

	def collection
	end

	def quit
	end
end