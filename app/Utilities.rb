module Utilities
	
	module APIs
		
		URL = "http://www.boredapi.com/api/activity"
		
		def get_random
			uri = URI.parse(URL)
			response = Net::HTTP.get_response(uri)
			JSON.parse(response.body)
		end

		def get_advanced(opt:, val:)
			opts = ["type", "accessibility", "price", "participant"]
			if opts.include? opt
				url = URL + "?#{opt}=#{val}"
			else
				# puts Error
			end

			uri = URI.parse(url)
			response = Net::HTTP.get_response(uri)
			JSON.parse(response.body)
		end

		def get_activity(key)
			url = URL + "?key=#{key}"
			uri = URI.parse(url)
			response = Net::HTTP.get_response(uri)
			JSON.parse(response.body)
		end
		
		module_function :get_random, :get_advanced, :get_activity
	end

	# module FormatData
		
	# 	def self.puts_account_info(info)
	# 	end

	# 	def self.puts_activity(info)
	# 	end

	# 	def self.puts_collection_list(info)
	# 	end

	# 	def self.puts_collection(info)
	# 	end
	# end
	
end


# puts APIs.get_advanced(opt: "price", val: "0.9")
# puts Utilities::APIs.get_activity(5881028);