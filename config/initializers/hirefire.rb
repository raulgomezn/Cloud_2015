HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    #HireFire::Macro::Bunny.queue("test1", :connection => ENV['CLOUDAMQP_URL'])
    puts 'Inicio Leer Cola hirefire'

    b = Bunny.new ENV['CLOUDAMQP_URL']
    b.start # start a communication session with the amqp server
    
    q = b.queue 'test1' # declare a queue
    count = q.message_count.to_i
    puts count.to_i
    b.stop # close the connection
    b.close
    puts "<---Cerrar cola hirefire " + count.to_i
  end
end