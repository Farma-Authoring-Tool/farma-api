class Introduction < ActiveRecord::Migration[7.0]
  def change
    create_table :introductions do |t|
      t.string :title, index: { unique: true }
      t.string :description
      t.boolean :public
      t.integer :position
      t.integer :oa_id

      t.timestamps
    end
  end
end
