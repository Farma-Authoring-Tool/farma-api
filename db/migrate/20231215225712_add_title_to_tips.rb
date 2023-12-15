class AddTitleToTips < ActiveRecord::Migration[7.0]
  def change
    add_column :tips, :title, :string
    add_index :tips, :title, unique: true
  end
end
