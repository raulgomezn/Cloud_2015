class BackgroundController < ApplicationController

  #Congiracion AWS
  require "rubygems"
  require "bunny"
  require 'aws-sdk'
  require 'rufus-scheduler'

  def self.escribirCola(mensaje)
    puts '<-------COLA '+ mensaje
    puts "Inicio Escribir Cola Para Mensaje: " + mensaje
    
    b = Bunny.new ENV['CLOUDAMQP_URL']
    b.start # start a communication session with the amqp server
    
    q = b.queue 'test1' # declare a queue
    
    # publish a message to the queue
    q.publish mensaje
    
    b.stop # close the connection
    b.close
    
    puts "Fin Escribir Cola Para Mensaje: " + mensaje
  end

  def self.procesarVideo
    puts 'Inicio Procesar Video: '
    scheduler = Rufus::Scheduler.new
    scheduler.every '2m' do
      leerCola
    end
    scheduler.join
  end

  def self.leerCola
    #Leer Cola de Amazon SQS
    puts 'Inicio Leer Cola'

    b = Bunny.new ENV['CLOUDAMQP_URL']
    b.start # start a communication session with the amqp server
    
    q = b.queue 'test1' # declare a queue
    
    delivery_properties, headers, payload = q.pop # retrieve one message from the queue
    b.stop # close the connection
    b.close
    puts "º---CLOSE cola"
    puts "This is the message: " + payload
    
    if payload.nil?
      puts "<----> Seccion de convertirVideo"
      body = payload #m.body()
      arr = body.split('|')
      idEnt = arr[0];email = arr[1];keyTMP = arr[2];nArchivo = arr[3]
      keyS3 = keyTMP[1,keyTMP.length]
      puts 'Fin Leer Cola'
  
      #Descargar Video
      nArchivoOrig = idEnt+'_'+nArchivo
      descargarVideo(keyS3,nArchivoOrig)
  
      #Convertir Video
      nArchivoConv = nArchivoOrig[0,nArchivoOrig.index('.')]+'.mp4'
      convertirVideo(nArchivoOrig,nArchivoConv)
  
      #Subir Video Convertido a Amazon
      keyS3Conv = 'competitors/video_converteds/'+idEnt+'/'+nArchivoConv
  
      subirVideo(keyS3Conv,nArchivoConv)
  
      #Eliminar Archivo Temporales
      eliminarArchivos(nArchivoOrig,nArchivoConv)
  
      #Actualizar Estado En BD
      cambiarEstadoVideo(idEnt,nArchivoConv)
  
      #Enviar Correo Electronico al Usuario
      #enviarEmail(email,'Su video '+nArchivoOrig[0,nArchivoOrig.index('.')]+' está disponible para reproducción')
      UserMailer.video_email(email).deliver
      m.delete
    end
  end

  def self.descargarVideo(keyS3,nArchivo)

    puts 'Inicio Descargar Archivo: ' + keyS3
    s3 = AWS::S3.new(region: 'sa-east-1')
    bucket = s3.buckets['unicloudstorage']
    obj = bucket.objects[keyS3]
    File.open(nArchivo, 'wb') do |file|
      obj.read do |chunk|
        file.write(chunk)
      end
    end
    puts 'Fin Descargar Archivo'
  end

  def self.convertirVideo(nArchivoOrg,nArchivoConv)
    puts 'Inicio Convertir Video: ' + nArchivoConv
    system("ffmpeg -i #{nArchivoOrg} #{nArchivoConv}")
    puts 'Fin Convertir Video'
  end

  def self.subirVideo(keyS3,archivo)
    puts 'Inicio Subir Video'
    s3 = AWS::S3.new(region: 'sa-east-1')
    bucket = s3.buckets['unicloudstorage']
    obj = bucket.objects[keyS3]
    obj.write(File.open(archivo, 'rb'),:acl => :public_read)
    puts 'Fin Subir Video'

  end

  def self.eliminarArchivos(narchivoOrg,nArchivoConv)
    File.delete(narchivoOrg)
    File.delete(nArchivoConv)
  end

  def self.cambiarEstadoVideo(id, nArchivoNuevo)
    @competitor = Competitor.find(id)
    @competitor.update_attributes(:status_video => 'Convertido', :video_converted_file_name => nArchivoNuevo)
  end

end