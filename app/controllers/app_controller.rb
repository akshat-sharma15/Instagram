class AppController < ApplicationController
  def home
    @users = User.where.not(id: current_user.id)
    @user = current_user
  end
end
