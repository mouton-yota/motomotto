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

    def edit
      @post = Post.find(params[:id])
    end
    def update
      @post = Post.find(params[:id])
      @post.update(post_params)
      redirect_to post_path(@post)
    end
    
    def destroy
      current_user.posts.find(params[:id]).destroy
      redirect_to [current_user]
    end

    def index
      @feeds = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
      # []内で*を入れる事で、二つの条件を展開、自分とフォロワーの投稿がタイムラインに出るようにする
      # オプションを付けて、投稿が新しい物が上に来るようにする
    end


    private

    def post_params
      params.require(:post).permit(:caption, :image)
    end
end
