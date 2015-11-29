HireFire::Resource.configure do |config|
  config.dyno(:worker) do
    #HireFire::Macro::Bunny.queue("test1", :connection => ENV['CLOUDAMQP_URL'])
    puts 'Inicio Leer Cola hirefire'

    b = Bunny.new ENV['CLOUDAMQP_URL']
    b.start # start a communication session with the amqp server
    
    q = b.queue 'test1' # declare a queue
    
    puts q.message_count
    b.stop # close the connection
    b.close
    puts "<---CLOSE cola hirefire"
  end
end