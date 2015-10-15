#!/bin/bash

# Variables de Entorno Para Conexion a Base de Datos
export PGHOST=${PGHOST-cloud2015.csxrnw9neitk.sa-east-1.rds.amazonaws.com}
export PGPORT=${PGPORT-5432}
export PGDATABASE=${PGDATABASE-cloud2015}
export PGUSER=${PGUSER-cloud}
export PGPASSWORD=${PGPASSWORD-cloud2015}

# Ejeuctar Consulta y Recorrer Resultado
contador=0
psql -X --set AUTOCOMMIT=off --set ON_ERROR_STOP=on -c "select id,video_original_file_name,email from competitors where status_video = 'En Proceso'"| 
while read id divisor video_original_file_name email ; do
    # Eliminar Cabeceras
	if test $contador -gt 1 
	then
	
	#Copiar Archivo a camperta local
	urldoc="s3://unicloudstorage/competitors/video_originals/$id/$video_original_file_name $video_original_file_name"
	aws s3 cp $urldoc
	
	#Convertir Video
	NOMBRE_DOC=`echo $video_original_file_name| cut -d'.' -f 1`.mp4
	ffmpeg -i $video_original_file_name -codec:v libx264 -codec:a libfdk_aac $NOMBRE_DOC
	
	#Copiar video convertido a amazonaw
	
	aws s3 cp $NOMBRE_DOC s3://unicloudstorage/competitors/video_converteds/$id/$NOMBRE_DOC --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
	
	rm -rf $NOMBRE_DOC
	rm -rf $video_original_file_name
	
	#Actualizar Estado
	psql -X --set AUTOCOMMIT=on --set ON_ERROR_STOP=on -c "update competitors set status_video = 'Convertido', video_converted_file_name = '$NOMBRE_DOC' where id = $id;"
	
	#Enviar Correo
    #sendmail -f admin@UniCloud.com -t $Correo -s smtp.gmail.com -u 'Video Convertido' -m the 'Su video ha sido convertido y puede ser visualizado.'
	fi
    let contador=contador+1
done
