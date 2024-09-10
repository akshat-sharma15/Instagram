class ChangeColoumnInPost < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :body, :caption
  end
end
