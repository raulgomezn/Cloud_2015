class HirefireController < ApplicationController
    respond_to :json
    
    def info
        puts 'Inicio Leer Cola HirefireController'

        b = Bunny.new ENV['CLOUDAMQP_URL']
        b.start # start a communication session with the amqp server
        
        q = b.queue 'test1' # declare a queue
        
        puts q.message_count
        b.stop # close the connection
        b.close
        puts "<---CLOSE cola HirefireController"
      
        render json: JSON.generate([
          {name: "worker", quantity: q.message_count}
        ])
    end

end