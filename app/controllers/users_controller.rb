##
# Controller for `/users` API methods, basic CRUD for <tt>User</tt> model.
#
class UsersController < ApplicationController
  before_action :authorize, except: :create
  before_action :set_user, except: %i[create index]

  ##
  # GET /users
  def index
    @users = User.all
  end

  ##
  # GET /users/<username>
  def show; end

  ##
  # POST /users
  def create
    protect_parameter_missing do
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created, location: @user unless performed?
      else
        render_error(:unprocessable_entity, nil, @user.errors) unless performed?
      end
    end
  end

  ##
  # PATCH/PUT /users/<username>
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render_error(:unprocessable_entity, nil, @user.errors)
    end
  end

  ##
  # DELETE /users/<username>
  def destroy
    @user.destroy
  end

  private

  ##
  # Use callbacks to share common setup or constraints between actions.
  #
  def set_user
    @user = User.find_by_username(params[:_username])
  rescue ActiveRecord::RecordNotFound => e
    render_error(:not_found, e)
  end

  ##
  # Only allow a list of trusted parameters through.
  #
  def user_params
    params.permit(:username, :name, :email, :bio, :password, :password_confirmation)
  end
end
