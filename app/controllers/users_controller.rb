class UsersController < ApplicationController
  def show
    user = User.find_by(id: params[:id])
    @followers = user.followers
    @following = user.followers
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

  def following
  #   following.include?(User.find_by(id: params[:id]))
  end
end
