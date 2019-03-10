class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
    render json: @sub
  end

  def new
    @sub = Sub.new
  end

  def create
    debugger
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      render json: @sub
    else
      render json: @sub.errors.full_messages
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      render json: @sub
    else
      render json: @sub.errors.full_messages
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
