class CreateActivityUsers < ActiveRecord::Migration[5.2]
	create_table :activity_users, :id => false do |t|
		t.belongs_to :activity
		t.belongs_to :user
 	end
end
  