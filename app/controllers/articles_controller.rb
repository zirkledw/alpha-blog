class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # I added this:
  # before_action :article_params, only: [:create, :update]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new

  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was created sucessfully."
      redirect_to @article #save is true
    else
      render 'new' #save is false
    end
  end

  def update
    # use same whitelist
    if @article.update(article_params)
      flash[:notice] = "Article was updated sucessfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy

    @article.destroy
    redirect_to articles_path
  end

  private #only used by this controller doesn't need an end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

end
