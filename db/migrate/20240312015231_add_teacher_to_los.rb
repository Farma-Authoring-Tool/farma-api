class AddTeacherToLos < ActiveRecord::Migration[6.0]
  def change
    add_reference :los, :teacher, foreign_key: { to_table: :users }
  end
end
