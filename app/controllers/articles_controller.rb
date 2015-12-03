class ArticlesController < ApplicationController
  include ArticlesHelper
  
  def index
    @articles = Article.all 
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new 
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
      flash[:notice] = "New article created"
    else
      render "new"
    end
  end
  
  def edit
    @article = Article.find(params[:id]) 
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article updated"
      redirect_to article_path(@article)
    else
      render "edit"
    end
  end
  
  def destroy
    Article.find(params[:id]).destroy
    flash[:notice] = "Article deleted"
    redirect_to articles_path
  end
end
