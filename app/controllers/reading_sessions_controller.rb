class ReadingSessionsController < ApplicationController
  before_action :set_reading_session, only: [:show, :update, :destroy]

  # GET /reading_sessions
  def index
    @reading_sessions = ReadingSession.all

    render json: @reading_sessions
  end

  # GET /reading_sessions/1
  def show
    render json: @reading_session
  end

  # POST /reading_sessions
  def create
    @reading_session = ReadingSession.new(reading_session_params)

    if @reading_session.save
      render json: @reading_session, status: :created, location: @reading_session
    else
      render json: @reading_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reading_sessions/1
  def update
    if @reading_session.update(reading_session_params)
      render json: @reading_session
    else
      render json: @reading_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reading_sessions/1
  def destroy
    @reading_session.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading_session
      @reading_session = ReadingSession.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reading_session_params
      params.require(:reading_session).permit(:name, :notes)
    end
end
