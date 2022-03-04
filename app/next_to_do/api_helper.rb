module ApiHelper
		
	URL = "http://www.boredapi.com/api/activity"
	
	def get_random

		uri = URI.parse(URL)
		return get_response(uri)
	end

	def get_advanced(opt:, val:)
		
		if opt == "category"
			opt = "type"
		end
		
		opts = ["type", "accessibility", "price", "participants"]
		
		if opts.include?(opt)
			url = URL + "?#{opt}=#{val}"
		else
			begin
				raise NextToDoError
			rescue NextToDoError => error
				puts error.invalid_argument
				NextToDo::home
			end
		end

		uri = URI.parse(url)		
		return get_response(uri)
	end

	def get_activity(key)
		
		url = URL + "?key=#{key}"
		uri = URI.parse(url)
		return get_response(uri)
	end

	def get_response(uri)
		
		response = Net::HTTP.get_response(uri)
		
		case response
			when Net::HTTPSuccess
				info = JSON.parse(response.body)
				if info.keys[0] == "error"
					return {status: "warning", info: info["error"]}
				else
					return {status: "success", info: info}
				end
			else
				error_text = response.code.to_s + " : " + response.message
				return {status: "error", info: error_text}
		end
	end
	
	module_function :get_random, :get_advanced, :get_activity, :get_response
end