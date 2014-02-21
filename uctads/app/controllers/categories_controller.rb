class CategoriesController < ApplicationController
  def index
    @categories = Category.hash_tree
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])

    tree = Category.hash_tree
    t = tree
    if not @category.parent.nil?
      @category.ancestors.reverse_each do |c|
        t = t[c]
      end
    end
    t.except!(@category)

    @parents = build_parent_tree(tree, nil, 0)

  end

  def update
    category = Category.find(params[:id])
    category.update_attributes!(category_params)
    redirect_to category
  end

  def new
    @category = Category.new
    @parents = build_parent_tree(Category.hash_tree, nil, 0)
  end

  def create
    category = Category.new(category_params)
    if category.save
        redirect_to categories_path, notice: "Category '#{category.name}' successfully created."
    else
        render action: 'new'
    end
  end

  def destroy
    category = Category.find(params[:id])
    children = category.descendants
    children.each do |c|
      c.delete
    end
    category.delete
    redirect_to categories_path
  end

  private
    def category_params
      r = params.require(:category).permit(:name, :fields, :parent_id)
      r['fields'] = JSON.parse(r['fields'])
      return r
    end

    def build_parent_tree(h, o, i)
      o = [] if not o
      h.each_pair do |k,v|
        k.name = '-'*i + k.name
        o.push(k)
        build_parent_tree(v, o, i+2)
      end
      return o
    end

end
