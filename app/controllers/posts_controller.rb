class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def new
      @post = current_user.posts.new
    #　ログインユーザーのidも保存する為
    end

    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
    end

    def create
      @post = current_user.posts.new(post_params)

      if @post.save
        redirect_to root_url
      else
        render :new
      end
    end
    
    private

    def post_params
      params.require(:post).permit(:caption, :image)
    end
end
