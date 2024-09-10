class ChangeColoumnTypeAndNameInPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :title, :state
    change_column :posts, :state, :integer
  end
end
