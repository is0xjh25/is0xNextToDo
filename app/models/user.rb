class User < ActiveRecord::Base

	has_many :activity_users
    has_many :activities, through: :activity_users

	def info
		return {username: self.username, password: self.password, email: self.email}
	end

	def self.all_info
		users = {}
		User.all.each {|user| users.store(user.id, user.info)}
		return users
	end

	def self.login?(username: username, password: password)
		user = User.find_by(username: username)
		if user && user.password == password
			return true
		else
			return false
		end
	end

	def self.create_account(account)
		if !self.exists?(account[:username].downcase) && !self.exists?(account[:email].downcase)
			self.find_or_create_by(username: account[:username].downcase, password: account[:password], email:account[:email].downcase)
		else
			begin
				raise NextToDo::NextToDoError
			rescue NextToDo::NextToDoError => error
				puts error.create_account_failed
				NextToDo::home
			end
		end
	end

	def self.update_password(username: username, password: password)
		if self.exists?(username:username)
			user = User.find_by(username: username)
			user.password = password
			user.save
			return true
		else
			return false
		end
	end

	def collection_save(info: info)
		activity = Activity.store_activity(info)
		ActivityUser.find_or_create_by(user: self, activity: activity)
	end

	def collection_remove(info: info)
		
		activity = Activity.find_by(key: info[:key])

		# last activity in all users' collection
		if ActivityUser.where(activity_id: activity.id).size == 1
			Activity.where(key: info[:key]).delete_all	
		end
		
		ActivityUser.where(user_id: self.id, activity_id: activity.id).delete_all
	end

	def show_collection(sort: sort, order: order)
		res = []
		arg = "#{sort} #{order}"
		self.activities.order(arg).each {|a| res << a.info}
		return res
	end
end