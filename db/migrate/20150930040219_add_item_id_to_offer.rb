class AddItemIdToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :item_id, :integer
  end
end
