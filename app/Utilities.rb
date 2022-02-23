module Utilities
	
	module APIs
		
		URL = "http://www.boredapi.com/api/activity"
		
		def self.get_random
			uri = URI.parse(URL)
			response = Net::HTTP.get_response(uri)
			JSON.parse(response.body)
		end

		def self.get_advanced(opt:, val:)
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

		def self.get_activity(key)
			url = URL + "?key=#{key}"
			uri = URI.parse(url)
			response = Net::HTTP.get_response(uri)
			JSON.parse(response.body)
		end
	end

	module FormatData
		
		def self.puts_account_info(info)
		end

		def self.puts_activity(info)
		end

		def self.puts_collection_list(info)
		end

		def self.puts_collection(info)
		end
	end
end


# puts APIs.get_advanced(opt: "price", val: "0.9")
# puts Utilities::APIs.get_activity(5881028);