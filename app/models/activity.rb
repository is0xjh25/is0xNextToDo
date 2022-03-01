class Activity < ActiveRecord::Base
	
	has_many :activity_users
    has_many :users, through: :activity_users

	def info
		return {activity: self.activity, category: self.category, participants: self.participants, accessibility: self.accessibility, price: self.price, key: self.key}
	end

	def self.all_info
		activities = {}
		Activity.all.each {|a| activities.store(a.id, a.info)}
		return activities
	end
	
	def self.store_activity(info)
				
		activity = info["activity"]
		category = info["category"]
		participants = info["participants"]
		accessibility = info["accessibility"]
		price = info["price"]
		key = info["key"]

		self.find_or_create_by(activity: activity, category: category, participants: participants, accessibility: accessibility, price: price, key: key)
	end
end