class AddIsTeacherToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_teacher, :boolean, default: false, null: false
  end
end
