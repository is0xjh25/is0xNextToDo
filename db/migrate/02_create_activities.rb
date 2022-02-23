class CreateActivities < ActiveRecord::Migration[5.2]
	def change
	  create_table :activities do |t|
		t.string :name
		t.string :type
		t.integer :participant
		t.float :accessibility
		t.float :price
		t.string :web_link
		t.integer :key
	  end
	end
end