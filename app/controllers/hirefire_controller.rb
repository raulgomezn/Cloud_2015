class HireFireController < ApplicationController
  respond_to :json

  def info
    render json: JSON.generate([
      {name: "worker", quantity: 0},
      {name: "urgent", quantity: 0}
    ])
  end

  #private
#
  #def count_worker
  #  Delayed::Job
  #    .where(failed_at: nil)
  #    .where("run_at <= ?", Time.now.utc)
  #    .count
  #end
#
  #def count_urgent
  #  Delayed::Job
  #    .where(failed_at: nil)
  #    .where("run_at <= ?", Time.now.utc)
  #    .where(queue: "urgent")
  #    .count
  #end
end