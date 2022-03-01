class CreateCollections < ActiveRecord::Migration[5.2]
	def change
	  create_table :collections do |t|
		t.references :user
		t.references :activity
	  end
	end
end