class PostsController < ApplicationController
before_action :set_post, only: [:show, :edit, :update, :destroy]
skip_before_action :authenticate_user!, only: :index

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.new(post_params)
    @post.save
    respond_with(@post)
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:subject, :body, :user_id)
    end
end
