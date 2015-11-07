class BackgroundController < ApplicationController

  #Congiracion AWS
  require 'aws-sdk'
  require 'rufus-scheduler'
  AWS.config(:access_key_id => ENV['access_key_id'],
             :secret_access_key => ENV['secret_access_key'],
             :ses => { :region => 'us-east-1' })

  def self.escribirCola(mensaje)
    puts '<-------COLA '+ mensaje
    logger.info "Inicio Escribir Cola Para Mensaje: " + mensaje
    sqs = AWS::SQS.new(region: 'us-east-1')
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

  def self.procesarVideo
    puts 'Inicio ProcesarVideo: '
    scheduler = Rufus::Scheduler.new
    scheduler.every '30s' do
      leerCola
    end
    scheduler.join
  end

  def self.leerCola

    logger.info "Inicio leerCola"

    #Leer Cola de Amazon SQS
    puts 'Inicio Leer Cola'
    sqs = AWS::SQS.new(region: 'us-east-1')
    q = sqs.queues.create 'IN_Queue_UniCloud'
    m =  q.receive_messages

      body = m.body()
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
      enviarEmail(email,'Su video '+nArchivoOrig[0,nArchivoOrig.index('.')]+' está disponible para reproducción')

      m.delete

      #|Manejo de Excepciones
      #rescue
      # puts 'No Hay Mensajes por Procesar'

  end

  def self.descargarVideo(keyS3,nArchivo)

    puts 'Inicio Descargar Archivo: ' + keyS3
    s3 = AWS::S3.new(region: 'us-east-1')
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
    s3 = AWS::S3.new(region: 'us-east-1')
    bucket = s3.buckets['unicloudstorage']
    obj = bucket.objects[keyS3]
    obj.write(File.open(archivo, 'rb'),:acl => :public_read)
    puts 'Fin Subir Video'

  end

  def self.eliminarArchivos(narchivoOrg,nArchivoConv)
    File.delete(narchivoOrg)
    File.delete(nArchivoConv)
  end

  def self.enviarEmail(direccion,mensaje)
    #UserMailer.videoconvertido_email('ing.aduran@gmail.co
    # m').deliver
    ses = AWS::SimpleEmailService.new(region: 'us-east-1')
    #identity = ses.identities.verify('ing.aduran@gmail.com')
    ses.send_email(
        :subject => 'Unicloud - Video Convertido',
        :from => 'ea.duran@uniandes.edu.co',
        :to => direccion,
        :body_text => mensaje,
        :body_html => '<h1>'+mensaje+'</h1>')
  end

  def self.cambiarEstadoVideo(id, nArchivoNuevo)
    @competitor = Competitor.find(id)
    @competitor.update_attributes(:status_video => 'Convertido', :video_converted_file_name => nArchivoNuevo)
  end

end
