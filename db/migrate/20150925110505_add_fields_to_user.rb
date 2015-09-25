class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :deleted_at, :datetime
    add_column :users, :type, :string, default: nil
  end
end
