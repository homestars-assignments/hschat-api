##
# Controller for `/channels` API methods, basic CRUD for <tt>Channel</tt> model.
#
class ChannelsController < ApplicationController
  before_action :authorize
  before_action :set_channel, only: %i[show update destroy join leave]

  ##
  # GET /channels
  def index
    received_param = filter_params[:joined]
    show_joined_channels = received_param == 'true'
    @channels = Channel.all unless show_joined_channels
    @channels = @current_user.channels if show_joined_channels
  end

  ##
  # GET /channels/1
  # GET /channels/1.json
  def show; end

  ##
  # POST /channels/1/join
  def join
    if !@current_user.channels.include?(@channel)
      @current_user.channels << @channel
      render :show, status: :ok, location: @channel
    else
      render_error(:bad_request, StandardError.new('Already joined'))
    end
  rescue StandardError => e
    render_error(:bad_request, e, @current_user.errors)
  end

  ##
  # POST /channels/1/leave
  def leave
    if @current_user.channels.include?(@channel)
      @current_user.channels.delete(@channel)
      render :show, status: :ok, location: @channel
    else
      render_error(:bad_request, StandardError.new('Not joined to selected channel'))
    end
  rescue StandardError => e
    render_error(:bad_request, e, @current_user.errors)
  end

  ##
  # POST /channels
  # POST /channels.json
  def create
    @channel = Channel.new(channel_params)

    if @channel.save
      render :show, status: :created, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  ##
  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    if @channel.update(channel_params)
      render :show, status: :ok, location: @channel
    else
      render json: @channel.errors, status: :unprocessable_entity
    end
  end

  ##
  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @channel.destroy
  end

  private

  ##
  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  ##
  # Only allow a list of trusted parameters through.
  def channel_params
    params.require(:channel).permit(:name, :description)
  end

  ##
  # Expect optional <tt>joined</tt> parameter in params of controller.
  #
  def filter_params
    params.permit(:joined)
  end
end
