class CreateCompetitors < ActiveRecord::Migration
  def change
    create_table :competitors do |t|
      t.references :competition, index: true, foreign_key: true
      t.string :first_name
      t.string :second_name
      t.string :last_name
      t.string :second_last_name
      t.datetime :date_admission
      t.string :email
      t.text :message
      t.string :status_video
      t.string :url_video_original
      t.string :url_video_converted

      t.timestamps null: false
    end
  end
end
