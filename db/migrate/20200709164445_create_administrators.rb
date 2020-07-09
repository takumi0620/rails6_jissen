class CreateAdministrators < ActiveRecord::Migration[6.0]
  def change
    create_table :administrators do |t|
      t.string :email
      t.string :hashed_password
      t.boolean :suspended
      t.timestamps
    end

  add_index :administrators, "LOWER(email)", unique: true
  end
end
