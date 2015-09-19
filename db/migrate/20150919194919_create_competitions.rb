class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.references :users, index: true, foreign_key: true
      t.string :name
      t.string :url
      t.datetime :start_date
      t.datetime :end_date
      t.text :prize
      t.string :image

      t.timestamps null: false
    end
  end
end
