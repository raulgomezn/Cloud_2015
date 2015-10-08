#!/bin/bash

LIST=`sqlite3 /home/ubuntu/workspace/db/development.sqlite3 "select substr('000' || id, -3, 3),video_original_file_name,email from competitors where status_video = 'En Proceso';"`

echo 'PRUEBA: '$LIST

for ROW in $LIST; do

    #Obtener Identificador del video
    id=`echo $ROW | awk '{split($0,a,"|"); print a[1]}'`
    #Obtener Nombre del Video
    nombre=`echo $ROW | awk '{split($0,a,"|"); print a[2]}'`
    #Obtener Correo Electronico Competidor
    correo=`echo $ROW | awk '{split($0,a,"|"); print a[3]}'`
    
    #PATH VIDEO
    PATH_VIDEOS_ORIGINAL=public/system/competitors/video_originals/000/000/$id/original
    
    mkdir -p public/system/competitors/video_converteds/000/000/$id/original
    
    PATH_VIDEOS_CONVERTIDO=public/system/competitors/video_converteds/000/000/$id/original
    NOMBRE_DOC=`echo $nombre| cut -d'.' -f 1`.mp4
    
    
    #Convertir Videos
    ffmpeg -i $PATH_VIDEOS_ORIGINAL/$nombre -codec:v libx264 -codec:a libfdk_aac $PATH_VIDEOS_CONVERTIDO/$NOMBRE_DOC
    
    #Actualizar Estado Video
    sqlite3 /home/ubuntu/workspace/db/development.sqlite3 "update competitors set status_video = 'Convertido', video_converted_file_name = '$NOMBRE_DOC' where id = $id;"
    
    #Enviar Correo
    sendmail -f admin@UniCloud.com -t $Correo -s smtp.gmail.com -u 'Video Convertido' -m the 'Su video ha sido convertido y puede ser visualizado.'
    
done