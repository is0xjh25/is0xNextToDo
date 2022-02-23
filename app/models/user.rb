class User < ActiveRecord::Base
	has_many :collection
	has_many :activity, through: :collection
end