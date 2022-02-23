class CreateCollections < ActiveRecord::Migration[5.2]
	def change
	  create_table :collections do |t|
		t.string :name
		t.text :description
		t.float :avg_participant
		t.float :avg_accessibility
		t.float :avg_price 
	  end
	end
end