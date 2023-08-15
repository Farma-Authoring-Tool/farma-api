class CreateLos < ActiveRecord::Migration[7.0]
  def change
    create_table :los do |t|
      t.string :title
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
