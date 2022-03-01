class Activity < ActiveRecord::Base
	
	has_many :collections
	has_many :users, through: :collections

	def info
		return {name: self.name, category: self.category, participants: self.participants, accessibility: self.accessibility, price: self.price, key: self.key}
	end

	def self.activities_info
		activities = {}
		Activity.all.each {|a| activities.store(a.id, a.info)}
		return activities
	end
	
	def self.store_activity(info)
		
		name = info["activity"]
		category = info["type"]
		participants = info["participants"]
		accessibility = info["accessibility"]
		price = info["price"]
		key = info["key"]

		return self.find_or_create_by(name: name, category: category, participants: participants, accessibility: accessibility, price: price, key: key)
	end

	def self.save_activity(username: username, info: info)
		activity = self.store_activity(info)
		activity.user = User.find_by(username: username)
	end
end