class AddUniqueIndexToLoTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :los, :title, unique: true
  end
end
