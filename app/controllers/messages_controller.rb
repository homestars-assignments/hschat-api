##
# Controller for `/messages` API methods, basic CRUD for <tt>Message</tt> model.
# Expected listings and creation under a container. Container can be a channel for public messages
# or another user for private messages.
#
class MessagesController < ApplicationController
  before_action :authorize
  before_action :set_message, only: %i[show update destroy]
  before_action :detect_parent, only: %i[index create]

  attr_reader :parent_object, :messages, :message

  ##
  # GET /messages
  def index
    render_invalid_parent and return unless parent_object

    @messages = parent_object.messages.includes(:user) if parent_object
  end

  ##
  # GET /messages/1
  def show; end

  ##
  # POST /messages
  def create
    render_invalid_parent and return unless parent_object

    @message = parent_object.messages.new # This way of creation implies targetable
    @message.user = current_user # The sender is current user
    @message.body = params[:body] # The message content should is the only input post parameter used

    if @message.save
      render :show, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  ##
  # PATCH/PUT /messages/1
  def update
    if @message.update(updatable_message_params)
      render :show, status: :ok, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  ##
  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

  ##
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  ##
  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:body)
  end

  ##
  # Only allow a list of trusted parameters through.
  def updatable_message_params
    # Only allows to update message content, not sender nor target.
    params.require(:message).permit(:body)
  end

  ##
  # Set value for <tt>parent_object</tt> according to nested routing.
  #
  def detect_parent
    # Actually the whole API is only implemented for Channel messages but this is assuming it a little more generic...
    parent_classes = %w[user channel]
    parent_class = parent_classes.detect { |pk| params[:"#{pk}_id"].present? }
    @parent_object = parent_class.camelize.constantize.find params[:"#{parent_class}_id"] if parent_class
  end

  ##
  # Calls <tt>ApplicationController::render_error</tt> assuming an invalid call made for an action
  # designed to be used inside a nested routed (or the parent_object isn't found).
  #
  def render_invalid_parent
    render_error(:not_found, StandardError.new('Invalid messages container'))
  end
end
