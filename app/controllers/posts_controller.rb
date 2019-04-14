class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  
  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    
    if @vote.valid?
      flash[:notice] = 'Your vote was counted.'
    else
      flash[:error] = "You can vote only once."
    end
    
    redirect_back(fallback_location: root_path)
  end

  def index
    # get all posts and sort them by votes in descending order
    @posts = Post.all.sort_by{|post| post.total_votes }.reverse
    render 'index'
  end
  
  def show
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    
    if @post.save
      flash[:notice] = 'Your post was created'
      redirect_to posts_path
    else
      flash[:notice] = 'Your post was not created'
      render :new
    end
    
  end
  
  def edit
    render :edit
  end
  
  def update
    if @post.update(post_params)
      flash[:notice] = 'Your post was updated'
      redirect_to post_path(@post)
    else 
      flash[:notice] = 'Your post was not updated'
      render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
end
