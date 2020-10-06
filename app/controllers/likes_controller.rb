class LikesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def index
    @posts = Post.joins(:likes).where(likes: { user_id: params[:user_id] }).order(created_at: :desc)
  end

  def create
    current_user.likes.create(post_id: params[:post_id])
    redirect_to [:post, { id: params[:post_id] }]
  end

  def destroy
    current_user.likes.find_by(post_id: params[:post_id]).destroy
    redirect_to [:post, { id: params[:post_id] }]
  end

end
