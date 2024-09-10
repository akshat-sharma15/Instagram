class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by(id: params[:id])
    @followers = @user.followers
    @following = @user.following
    @mutuals = current_user.following & @followers unless current_user == @user
  end

  def follow(target_user = nil)
    target_user ||= User.find_by(id: params[:id])
    current_user.following << target_user unless self == target_user || current_user.following.include?(target_user)
    redirect_to '/app/home'
  end

  def unfollow(target_user = nil)
    target_user ||= User.find_by(id: params[:id])
    current_user.following.delete(target_user)
    redirect_to '/app/home'
  end
end
