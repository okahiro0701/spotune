class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show]

  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def search
    if params[:search].present?
    @searchartists = RSpotify::Artist.search(params[:search])
    end
    render:new
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    binding.pry
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else 
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  def edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to root_path
  end

  def show
  end

  private
  def post_params
    params.require(:post).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
