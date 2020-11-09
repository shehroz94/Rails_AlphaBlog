class ArticlesController < ApplicationController
  
 

  def index
    @articles = Article.all
    @users = User.all
  end

  def create
    @article = Article.new(params.require(:articles).permit(:title, :description))
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was saved successfully"
      redirect_to @article
    else
      render 'new'
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def show
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was updated successfuly"
      redirect_to '/articles'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article was deleted successfully"
    end
    redirect_to '/articles'
  end
  
end