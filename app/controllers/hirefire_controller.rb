class HirefireController < ApplicationController
    respond_to :json
    
    def info
        puts 'Inicio Leer Cola HirefireController'
    
        b = Bunny.new ENV['CLOUDAMQP_URL']
        b.start # start a communication session with the amqp server
        
        q = b.queue 'test1' # declare a queue
        count = q.message_count.to_i
        #puts count.to_i
        b.stop # close the connection
        b.close
        puts "<---Cerrar cola hirefire HirefireController" + count.to_s

        render json: JSON.generate([
          {name: "worker", quantity: count}
        ])
    end

end