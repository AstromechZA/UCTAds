class CategoryController < ApplicationController
  def index
    @categories = Category.all
  end

  def tree
    @categories = Category.hash_tree
  end
end
