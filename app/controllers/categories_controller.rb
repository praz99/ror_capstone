class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:new]
  before_action :set_category, only: [:show]

  def index
    @categories = Category.ordered_priority
  end

  def home
    @categories = Category.ordered_priority.limit(4)
    @featured_article = Article.popular
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'You created a new category!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @articles = @category.articles.order('created_at DESC').includes(:author)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :priority)
  end
end
