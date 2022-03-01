class User < ActiveRecord::Base

	has_many :collections
	has_many :activities, through: :collections

	def info
		return {username: self.username, password: self.password, email: self.email}
	end

	def self.users_info
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
end