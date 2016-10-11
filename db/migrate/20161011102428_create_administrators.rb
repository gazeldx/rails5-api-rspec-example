class CreateAdministrators < ActiveRecord::Migration[5.0]
  def change
    create_table :administrators do |t|
      t.string :email, index: true
      t.string :token, index: true
      t.string :full_name
      t.string :password_digest
      t.text :description
      t.timestamps
    end
  end
end
