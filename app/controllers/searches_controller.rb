class SearchesController < ApplicationController
  def search
    @range = params[:range]
    word = params[:word]
      if @range == '1'
         @users = User.where("bike LIKE?","%#{word}%")
      else
         @posts = Post.where("caption LIKE?","%#{word}%")
      end
  end
end
