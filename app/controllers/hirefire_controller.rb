class HirefireController < ApplicationController
    respond_to :json
    
    def info
        puts 'Inicio Leer Cola HirefireController'

        b = Bunny.new ENV['CLOUDAMQP_URL']
        b.start # start a communication session with the amqp server
        
        q = b.queue 'test1' # declare a queue
        
        q.message_count
        b.stop # close the connection
        b.close
        puts "<---CLOSE cola HirefireController. " + q.message_count.to_s
      
        render json: JSON.generate([
          {name: "worker", quantity: 0}
        ])
    end

end