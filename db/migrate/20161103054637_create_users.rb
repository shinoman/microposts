class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :sexes
      t.string :area
      t.string :profile

      t.timestamps null: false
      t.index :email, unique: true
    end
  end
end
