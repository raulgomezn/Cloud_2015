class HirefireController < ApplicationController
  respond_to :json

  def info
    render json: JSON.generate([
      {name: "worker", quantity: count_worker}
    ])
  end

  private

  def count_worker
    puts 'Inicio Leer Cola HirefireController'

    b = Bunny.new ENV['CLOUDAMQP_URL']
    b.start # start a communication session with the amqp server
    
    q = b.queue 'test1' # declare a queue
    
    #puts q.message_count
    b.stop # close the connection
    b.close
    puts "<---CLOSE cola HirefireController"
    q.message_count
  end

end