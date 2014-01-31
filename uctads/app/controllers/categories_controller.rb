class CategoriesController < ApplicationController
  def index
    @categories = Category.hash_tree
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category].permit(:name, :fields))
    if @category.save
        redirect_to categories_path, notice: "Category '#{@category.name}' successfully created."
    else
        render action: 'new'
    end
  end
end
