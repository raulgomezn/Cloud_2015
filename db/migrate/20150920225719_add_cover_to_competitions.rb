# Se agrega la propiedad cover para poder recibir archivos ya sea imagenes o videos
# por medio de la gema paperclip

class AddCoverToCompetitions < ActiveRecord::Migration
  def change
    remove_column :competitions, :image
    
    remove_column :competitors, :url_video_original
    remove_column :competitors, :url_video_converted
  end
end
