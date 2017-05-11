class ChangeColumnBackgroundColorToUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :background_color, :string, default: "#005a55"
  end
end
