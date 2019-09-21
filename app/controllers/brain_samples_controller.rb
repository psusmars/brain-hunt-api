class BrainSamplesController < ApplicationController
  before_action :set_reading_session, only: [:index, :create]
  before_action :set_brain_sample, only: [:show, :update, :destroy]

  # GET /brain_samples
  def index
    @brain_samples = @reading_session.brain_samples
  end

  # GET /brain_samples/1
  def show
    render json: @brain_sample
  end

  # POST /brain_samples
  def create
    @brain_sample = @reading_session.brain_samples.build(brain_sample_params)

    if @brain_sample.save
      render json: @brain_sample, status: :created, location: @brain_sample
    else
      render json: @brain_sample.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /brain_samples/1
  def update
    if @brain_sample.update(brain_sample_params)
      render json: @brain_sample
    else
      render json: @brain_sample.errors, status: :unprocessable_entity
    end
  end

  # DELETE /brain_samples/1
  def destroy
    @brain_sample.destroy
  end

  private
    def set_reading_session
      @reading_session = ReadingSession.find(params[:reading_session_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_brain_sample
      @brain_sample = BrainSample.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def brain_sample_params
      params.require(:brain_sample).permit(:sample_rate, :number_of_channels, :reading_session_id, :channel_values)
    end
end
