class UsersController < ApplicationController

  def index
    @user = User.all
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: 422
      )
    end
  end

  def update
    # @user = User.find_by_id(params[:id])
    # if @user
    #   @user = User.update(params[:id], user_params)
    #   render json: @user
    # else
    #   render json: ["User not found."], status: :not_found
    # end
    #
    @user = User.find_by_id(params[:id])
    if @user && @user.update_attributes(user_params)
      render json: @user
    elsif @user
      render json: @user.errors.full_messages, status: :unprocessable_entity
    else
      render json: ["User not found"], status: :not_found
    end


  end

  def show
    @user = User.find_by_id(params[:id])
    if @user
      render json: @user
    else
      render json: ["User not found."], status: :not_found
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if @user
      @user.destroy
      render json: @user
    else
      render json: ["User not found"], status: :not_found
    end
  end

  private
  def user_params
    params[:user].permit(:name, :email)
  end


end
