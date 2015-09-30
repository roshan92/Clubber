class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
    	t.integer :offer_id
    	t.integer :user_id
    	t.integer :quantity
    	t.decimal :amount
    	t.boolean :paid, default: false
    	t.datetime :paid_on

      t.timestamps null: false
    end
    
    add_index :bookings, :offer_id
    add_index :bookings, :user_id
  end
end
