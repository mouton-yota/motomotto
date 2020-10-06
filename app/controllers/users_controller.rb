class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def index
    @feeds = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    # []内で*を入れる事で、二つの条件を展開、自分とフォロワーの投稿がタイムラインに出るようにする
    # オプションを付けて、投稿が新しい物が上に来るようにする
  end
end
