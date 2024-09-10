class PostsController < ApplicationController
  def new
    @user = current_user
    @post = @user.posts.new
  end

  def create
    @user = current_user
    @post = @user.posts.create(post_params)
    if @post
      flash[:success] = 'Posted successfully'
    end
    redirect_to '/app/home'
  end

  private

  def post_params
    params.require(:post).permit(:caption, :media)
  end
end
