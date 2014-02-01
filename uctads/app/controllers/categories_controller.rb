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

  def update
    category = Category.find(params[:id])
    category.update_attributes!(category_params)
    redirect_to category
  end

  def new
    @category = Category.new
  end

  def create
    category = Category.new(category_params)
    if category.save
        redirect_to categories_path, notice: "Category '#{category.name}' successfully created."
    else
        render action: 'new'
    end
  end

  private
    def category_params
      r = params.require(:category).permit(:name, :fields)
      r['fields'] = JSON.parse(r['fields'])
      return r
    end

end
