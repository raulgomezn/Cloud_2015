class HomecompetitorsController < ApplicationController

  def index
    @competition = Competition.find_by url: params[:url]
    @competitors = Competitor.where("competitions_id = ? and status_video = 'Convertido'", @competition.id).paginate(:page => params[:page], :per_page => 50)

  end

  def homecompetitors_params
    params.require(:homecompetitors).permit(:url)
  end

end