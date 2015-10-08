class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firts_name
      t.string :second_name
      t.string :last_name
      t.string :second_last_name
      t.string :email
      t.string :password
      t.boolean :isadmin

      t.timestamps null: false
    end
    
    create_table :competitions do |t|
      t.string :name
      t.string :url
      t.datetime :start_date
      t.datetime :end_date
      t.text :prize

      t.timestamps null: false
    end
    
    create_table :competitors do |t|
      t.string :first_name
      t.string :second_name
      t.string :last_name
      t.string :second_last_name
      t.datetime :date_admission
      t.string :email
      t.text :message
      t.string :status_video

      t.timestamps null: false
    end
  end
end
