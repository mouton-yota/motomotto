class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def new
      @post = current_user.posts.new
    #　ログインユーザーのidも保存する為
    end

    def show
      @post = Post.find(params[:id])
      @comment = Comment.new
      @tags = @post.tag_counts_on(:tags)
    end

    def create
      @post = current_user.posts.new(post_params)

      if @post.save
        tags = Vision.get_image_data(@post.image)    
        tags.each do |tag|
          post.tags.create(name: tag)
        end
        redirect_to posts_path
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
      if params[:tag]
        @feeds = Post.tagged_with(params[:tag]).order(created_at: :desc)
      else
        @feeds = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
        # []内で*を入れる事で、二つの条件を展開、自分とフォロワーの投稿がタイムラインに出るようにする
        # オプションを付けて、投稿が新しい物が上に来るようにする
        @posts = Post.all
      end
    end


    private

    def post_params
      params.require(:post).permit(:caption, :image, :tag_list)
    end
end
