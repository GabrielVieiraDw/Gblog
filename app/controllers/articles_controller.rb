class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit show destroy update]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article created!"
      redirect_to @article
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated!"
      redirect_to @article
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    if @article.destroy
      redirect_to articles_path, notice: 'Article deleted!'
    else
      render :index
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end

end
