class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firts_name
      t.string :second_name
      t.string :last_name
      t.string :second_last_name
      t.string :email
      t.string :password
      t.boolean :IsAdmin

      t.timestamps null: false
    end
  end
end
