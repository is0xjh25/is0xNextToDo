class CreateActivities < ActiveRecord::Migration[5.2]
	def change
	  create_table :activities do |t|
		t.string :activity, :null => false
		t.string :category, :null => false
		t.integer :participants, :null => false
		t.float :accessibility, :null => false
		t.float :price, :null => false
		t.integer :key, :null => false
	  end
	end
end