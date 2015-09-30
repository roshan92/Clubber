class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :name
    	t.text :description
    	t.decimal :price
      t.integer :user_id

      t.timestamps null: false
    end
    
    add_index :items, :user_id
  end
end
