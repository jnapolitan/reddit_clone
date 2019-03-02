class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      login(@user)
    else
      flash.now[:errors] = ['Invalid username or password.']
    end
  end

  def destroy
    logout
  end
end
