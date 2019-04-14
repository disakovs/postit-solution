class CommentsController < ApplicationController
  before_action :require_user
  
  def vote
    comment = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: comment)
    
    if @vote.valid?
      flash[:notice] = 'Your vote is counted.'
    else
      flash[:error] = 'You can vote only once'
    end
  
    redirect_back(fallback_location: root_path)
  end

  def create
    
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user
    
    if @comment.save
      flash[:notice] = 'Comment saved'
      redirect_to post_path(@post)
    else
      flash[:notice] = 'Comment not saved'
      render 'posts/show'
    end
  end
end
