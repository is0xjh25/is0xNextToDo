class CreateActivities < ActiveRecord::Migration[5.2]
	def change
	  create_table :activities do |t|
		t.string :event
		t.float :accessibility
		t.string :type
		t.float :price
		t.string :web_link
		t.integer :key
	  end
	end
end