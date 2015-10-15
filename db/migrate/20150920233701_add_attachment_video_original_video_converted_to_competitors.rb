class AddAttachmentVideoOriginalVideoConvertedToCompetitors < ActiveRecord::Migration
  
  def change
    add_attachment :competitors, :video_original
    add_attachment :competitors, :video_converted
    
    add_attachment :competitions, :banner
  end

end
