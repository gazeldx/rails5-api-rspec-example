class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :token
      t.string :full_name
      t.string :password_digest
      t.string :description

      t.timestamps
    end
  end
end
