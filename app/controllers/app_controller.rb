class AppController < ApplicationController
  def home
    @users = User.where.not(id: current_user.id) if current_user
    @user = current_user
  end
end
