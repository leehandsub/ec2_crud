class PostController < ApplicationController
  before_action :authenticate_user!, except: :index
  
  def index
    @post = Post.all.reverse
  end

  def new
  end

  def create
    image= ImageUploader.new
    image.store!(params[:image])
    
    @post = Post.new
    @post.title = params[:title]
    @post.content = params[:content]
    @post.user_id = current_user.id
    @post.image = image.url
    @post.image_thumb = image.thumb.url
    @post.save
    
    redirect_to "/post/view/" + @post.id.to_s
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.content = params[:content]
    @post.save
    
    redirect_to "/post/view/" + params[:id]
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    redirect_to '/post/index'
  end

  def view
    @post = Post.find(params[:id])
    @all_post = Post.all.reverse
  end
end
