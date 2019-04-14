class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(categories_params)
    
    if @category.save
      flash[:notice] = 'You added a category'
      redirect_to root_path
    else
      flash[:notice] = 'You failed'
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    
    if @category.update(categories_params)
      flash[:notice] = 'You updated a category'
      redirect_to categories_path
    else 
      flash[:notice] = 'You failed'
      render :edit
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'You deleted this category'
    redirect_to categories_path
    
  end
  
  private
  
  def categories_params
    params.require(:category).permit(:name)
  end
end
