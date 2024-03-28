class AddUserToLos < ActiveRecord::Migration[7.0]
  def change
    add_reference :los, :user, foreign_key: true
  end
end
