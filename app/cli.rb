module CLI

	# Static Variables
	INITIAL_USER = "Unknown User"
	GAP_LINE = "\n\n"
	VER = "|"
	HOR = "~"
	DIVIDER_LENGTH = 60
	DIVIDER_SYMBOL = "="
	DIVIDER = "============================================================"
	EMPHASIZE_SYMBOL_F = "<<< "
	EMPHASIZE_SYMBOL_E = " >>>"
	START = "[is0]: " 
	START_WARNING = "[WARNING]: "
	START_ERROR = "[ERROR]: "
	WHITE_SPACE = " "
	QUIT = "q"
	MENU = "m"
	HOME = "h"
	BACK = "b"
	MAX_INPUT_ATTEMPT = 10
	MAX_LOGIN_ATTEMPT = 5

	# Setters and Getters
	def self.username=(value)
		@@username = value
	end

	def self.username
		@@username
	end

	def self.menu_visited=(value)
		@@menu_visited = value
	end

	def self.menu_visited
		@@menu_visited
	end

	def self.login_failed=(value)
		@@login_failed = value
	end

	def self.login_failed
		@@login_failed
	end

	def self.login_attempt=(value)
		@@login_failed = value
	end

	def self.login_attempt
		@@login_failed
	end

	# Entry
	class Cli

		def initialize
			CLI::setup
		end

		# start the CLI
		def call
			puts CLI::make_title("Welcome to NextToDo")
			puts GAP_LINE
			puts File.readlines('./resources/favicon.txt')
			puts
			puts File.readlines('./resources/hello.txt') 
			puts GAP_LINE
			print CLI::make_title("Developed by is0xjh25")
			
			input = CLI::get_char

			if input != "q"
				puts GAP_LINE
				puts File.readlines('./resources/app-description.txt')
				puts
				CLI::start
			else
				puts GAP_LINE
				CLI::quit
			end
		end
	end

	# Error Class for testing
	class CliError < StandardError

		def excessive_warning
			puts START_ERROR + "Retard Alert!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons." + GAP_LINE
		end

		def excessive_login_attempt
			puts START_ERROR + "Just take a rest!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons." + GAP_LINE
		end

		def options_overload
			START_ERROR + "Invalid number of options. Only accept 2, 3, 4, 8."
		end

		def option_too_long
			START_ERROR + "Text for option needs to be shorten."
		end
	end
end