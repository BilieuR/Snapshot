class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :like,
    :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @posts = Post.all.order('created_at DESC').page(params[:page]).per(3)
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your new post couldn't be created!
      Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def like
    if @post.liked_by current_user
      create_notification @post
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end

  def unlike
    if @post.unliked_by current_user
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    end
  end


  private

    def post_params
      params.require(:post).permit(:image, :caption)
    end

    def find_post
      @post = Post.find(params[:id])
    end

    def owned_post
      unless current_user == @post.user
        flash[:alert] = "That post doesn't belong to you!"
        redirect_to root_path
      end
    end

    def create_notification(post)
      return if post.user.id == current_user.id

      Notification.create(user_id: post.user.id,
      notified_by_id: current_user.id,
      post_id: post.id,
      identifier: post.id, #The user has liked this specific post
      notice_type: 'like')
    end
end
