class CreateLos < ActiveRecord::Migration[7.0]
  def change
    create_table :los do |t|
      t.string :title, index: { unique: true }
      t.string :description

      t.timestamps
    end
  end
end
