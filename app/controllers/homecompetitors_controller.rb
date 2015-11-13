class HomecompetitorsController < ApplicationController

  def index
    @competition = Competition.where(:url => params[:url]).first
    @competitors = Competitor.where(:competitions_id => @competition.id, :status_video => 'Convertido').all

  end

  def homecompetitors_params
    params.require(:homecompetitors).permit(:url)
  end

end