class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
    	t.decimal :price, default: 0
    	t.boolean :status, default: true
    	t.boolean :payment, default: false
    	t.integer :user_id, index: true
  	  t.datetime :deal_open_hour
    	t.datetime :deal_closed_hour
  	  t.integer :quantity, default: 0

      t.timestamps null: false
    end
  end
end
