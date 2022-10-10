class ArticlesController < ApplicationController
  before_action :set_article, only: %i[edit show destroy update]
  before_action :require_user, except: %i[show index]
  before_action :require_article_user, only: %i[edit update destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
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

  def require_article_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or edit your own article"
      redirect_to @article
    end      
  end

end
