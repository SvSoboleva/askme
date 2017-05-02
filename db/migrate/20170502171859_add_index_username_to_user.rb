class AddIndexUsernameToUser < ActiveRecord::Migration[5.0]
#домашка 49-2
  def change
    add_index :users, :username
  end
end
