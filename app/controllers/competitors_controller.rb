class CompetitorsController < ApplicationController
  before_action :set_competitor, only: [:show, :edit, :update, :destroy]
  before_action :permisos, only: [:show, :edit, :update, :destroy, :index]

  # GET /competitors
  # GET /competitors.json
  def index
    @competition = Competition.find(params[:competition_id])
    @competitors = @competition.competitors.all
  end

  # GET /competitors/1
  # GET /competitors/1.json
  def show
    @competitor = Competitor.find(params[:id])
  end

  # GET /competitors/new
  def new
    @competition = Competition.find(params[:competition_id])
    @competitor = Competitor.new
  end

  # GET /competitors/1/edit
  def edit
  end

  # POST /competitors
  # POST /competitors.json
  def create
    @competitor = Competitor.new(competitor_params)
    @competitor.video_converted = @competitor.video_original
    @competitor.status_video = 'En Proceso'
    @competitor.date_admission = Time.now.getutc
    @competition = Competition.find(@competitor.competitions_id)
    respond_to do |format|
      if @competitor.save
        #Inicio Escribir Mensaje en Cola
        BackgroundController.escribirCola("#{@competitor.id}|#{@competitor.email}|#{@competitor.video_original.path}|#{@competitor.video_original.original_filename()}")
        #Fin Escribir Mensaje en Cola
        format.html { redirect_to "/" + @competition.url, notice: 'Hemos Recibido Tu Video. Te Enviaremos un Correo Electronico Cuando el Video Este Disponible!' }
        format.json { render :show, status: :created, location: @competitor }
      else
        format.html { render :new }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competitors/1
  # PATCH/PUT /competitors/1.json
  def update
    respond_to do |format|
      if @competitor.update_attributes(competitor_params)
        format.html { redirect_to @competitor, notice: 'Competitor was successfully updated.' }
        format.json { render :show, status: :ok, location: @competitor }
      else
        format.html { render :edit }
        format.json { render json: @competitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competitors/1
  # DELETE /competitors/1.json
  def destroy
    id_competitor = @competitor.competitions_id

    respond_to do |format|
      format.html { redirect_to competitions_url + '/' + id_competitor.to_s, notice: 'Competitor was successfully destroyed.' }
      format.json { head :no_content }
    end
    @competitor.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_competitor
    @competitor = Competitor.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def competitor_params
    params.require(:competitor).permit(:competitions_id, :first_name, :second_name, :last_name, :second_last_name, :email, :message,  :video_original)
  end
  def permisos
    if(!logged_in?)
      redirect_to login_path
    end
  end
end
