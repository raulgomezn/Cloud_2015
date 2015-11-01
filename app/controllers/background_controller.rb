class BackgroundController < ApplicationController

  #Congiracion AWS
  require 'aws-sdk'
  AWS.config(:access_key_id => 'AKIAISZJW7GNMMEIWDGA',
             :secret_access_key => '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',
             :ses => { :region => 'us-east-1' })

  def self.escribirCola(mensaje)
    logger.info "Inicio Escribir Cola Para Mensaje: " + mensaje
    sqs = AWS::SQS.new()
    #q = sqs.queues.create 'competitors/video_originals/100/clases_primaria4.avi'
    q = sqs.queues.create 'IN_Queue_UniCloud'
    loop do
      if q.exists?
        puts "La cola ha sido creada en AWS"
        break
      end
      sleep 1
    end
    m = q.send_message mensaje
    logger.info "Fin Escribir Cola Para Mensaje: " + mensaje
  end


  def self.leerCola
    sqs = AWS::SQS.new()
    q = sqs.queues.create 'IN_Queue_UniCloud'
    m =  q.receive_messages
    puts 'Cuerpo del Mensaje: ' + m.body
    puts 'Cuerpo del Mensaje: ' + m.id




    m.delete
    #puts sqs.queues.collect(&:url)
  end

  def self.descargarVideo

    #DefinirVariables Variables
    key = 'competitors/video_originals/100/clases_primaria4.avi'
    arr = key.split('/')
    entidad = arr[0];atributo = arr[1];idEnt = arr[2];archivo = arr[3];atributoConv = 'video_converteds'
    archivoTmp = idEnt+'_'+archivo
    archivoConv = archivoTmp[0,archivoTmp.rindex('.')]+'.mp4'

    #Descargar Arhico S3
    s3 = AWS::S3.new
    bucket = s3.buckets['unicloudstorage']
    obj = bucket.objects[key]
    File.open(archivoTmp, 'wb') do |file|
      obj.read do |chunk|
        file.write(chunk)
      end
    end

    #Convertir Video
    system("ffmpeg -i #{archivoTmp} #{archivoConv}")

    #Subir Video
    objConv = bucket.objects[entidad+'/'+atributoConv+'/'+idEnt+'/'+archivoConv]
    objConv.write(File.open(archivoConv, 'rb'))

    #Eliminar Archivos Temporales
    File.delete(archivoConv)
    File.delete(archivoTmp)
    logger.info "Se finaliza la transaccion"

  end

  def self.enviarEmail
    ses = AWS::SimpleEmailService.new(
        :access_key_id => 'AKIAISZJW7GNMMEIWDGA',
        :secret_access_key => '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')
    puts ses.identities.map(&:identity)
  end

end
