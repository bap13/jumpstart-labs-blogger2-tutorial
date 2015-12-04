class CommentsController < ApplicationController
  include CommentsHelper
  
  def create
    @comment = Comment.new(comment_params)
    @comment.article_id = params[:article_id]
    
    if @comment.save
      redirect_to article_path(@comment.article)
    else
      @article = @comment.article 
      @comments = @comment.article.comments
      render 'articles/show'
    end
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @article.comments.find(params[:id]).destroy
    
    flash[:notice] = "Comment deleted"
    redirect_to @article
  end
end
