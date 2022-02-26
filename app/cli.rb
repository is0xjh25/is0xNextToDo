module CLI

	# Static Variables
	DEFAULT_USER = "Guest"
	GAP_LINE = "\n\n"
	BORDER = "-"
	VER = "|"
	HOR = "~"
	DIVIDER_LENGTH = 60
	DIVIDER_SYMBOL = "="
	DIVIDER = "============================================================"
	COPY_RIGHT = "======Developed by is0xjh25 X Supported by Bored-API======"
	EMPHASIZE_SYMBOL_F = "<<< "
	EMPHASIZE_SYMBOL_E = " >>>"
	START = "[is0]: " 
	START_WARNING = "[WARNING]: "
	START_ERROR = "[ERROR]: "
	WHITE_SPACE = " "
	QUIT = "Q"
	MENU = "M"
	HOME = "H"
	SAVE = "S"
	NEXT = "N"
	RESET = "R"
	YES = "Y"
	NO = "N"
	MAX_INPUT_ATTEMPT = 10
	MAX_LOGIN_ATTEMPT = 5
	MAX_RESCUE_ATTEMPT = 5

	# Setters and Getters
	def self.username=(value)
		@@username = value
	end

	def self.username
		@@username
	end

	def self.login_failed=(value)
		@@login_failed = value
	end

	def self.login_failed
		@@login_failed
	end

	def self.login_attempt=(value)
		@@login_attempt = value
	end

	def self.login_attempt
		@@login_attempt
	end

	def self.rescue_attempt=(value)
		@@rescue_attempt = value
	end

	def self.rescue_attempt
		@@rescue_attempt
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
			print COPY_RIGHT
			
			input = CLI::get_char
			puts GAP_LINE
			puts File.readlines('./resources/app-description.txt')
			puts
			CLI::start
		end
	end

	# Error Class for testing
	class CliError < StandardError

		def excessive_warning
			puts START_ERROR + "Retard Alert!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons."
		end

		def excessive_login_attempt
			puts START_ERROR + "Just take a rest!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons."
		end

		def excessive_rescue_attempt
			puts START_ERROR + "Don't try to hack!!!" + GAP_LINE
			puts START_ERROR + "The program is shutting down for security reasons."
		end

		def options_overload
			puts START_ERROR + "Invalid number of options. Only accept 2, 3, 4, 6, 7, 8."
		end

		def option_too_long
			puts START_ERROR + "Text for option needs to be shorten."
		end

		def invalid_argument
			puts START_ERROR + "Invalid argument."
		end

		def key_not_found
			puts START_ERROR + "The key cannot be found in the hash."
		end
	end
end