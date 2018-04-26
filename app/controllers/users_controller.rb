class UsersController < ApplicationController
  include ErrorSerializer
  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:create]
  before_action :set_user, only: [:show, :update]

  def index
    render json: User.all
  end

  def show
    if current_user
        render json: @user
    else
      render json: ErrorSerializer.serialize(["something is bad"]), status: 422
    end

  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {}, status: 200
    else
      render json: ErrorSerializer.serialize(user.errors), status: 422
    end
  end

  # PATCH/PUT /users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:fname, :lname, :email, :password, :password_confirmation)
    end


end
