class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :event_name
      t.text :event_description
      t.date :event_date
      t.time :event_time
      t.timestamps null: false
    end
    
    add_index :events, :user_id
  end
end
