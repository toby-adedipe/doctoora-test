class AddUserClassAndUserIdToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :user_class, :string
    add_column :messages, :user_id, :integer
  end
end
