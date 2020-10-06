class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to [@post]
    else
      render "posts/show"
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    comment.destroy
    redirect_to [:post, { id: params[:post_id] }]
  end


  private
  
  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
