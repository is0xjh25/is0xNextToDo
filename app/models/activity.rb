class Activity < ActiveRecord::Base
	belongs_to :user
	belongs_to :collection
end