class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :role
      t.string :password_digest

      t.timestamps
    end
    add_index :clients, :email, unique: true
  end
end
