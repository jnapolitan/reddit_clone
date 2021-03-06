class Api::SessionsController < ApplicationController

  def show
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
    else
      render json: ['Invalid username or password.']
    end
  end

  def destroy
    logout
  end

end
