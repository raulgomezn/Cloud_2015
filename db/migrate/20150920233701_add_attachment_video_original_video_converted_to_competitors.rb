class AddAttachmentVideoOriginalVideoConvertedToCompetitors < ActiveRecord::Migration
  
  def change
    add_attachment :competitors, :video_original
    add_attachment :competitors, :video_converted
    
    add_attachment :competitions, :banner
  end

end
  # def self.up
  #   change_table :competitors do |t|
  #     t.attachment :ejemplo
  #   end
  # end

  # def self.down
  #   remove_attachment :competitors, :ejemplo
  # end