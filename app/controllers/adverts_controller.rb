class AdvertsController < ApplicationController

  def index
    @adverts = Advert.order(created_at: :desc)

    #nested category tree
    @category_tree = {}

    # roots are always shown in the list
    Category.roots.each {|r| @category_tree[r] = {}}
  end

  def index_by_category
    @selected_category = Category.find(params[:id])

    @category_tree = @selected_category.root.hash_tree

    # roots are always shown in the list
    Category.roots.each do |r|
      unless @category_tree.has_key? r
        @category_tree[r] = {}
      end
    end

    ids = @selected_category.self_and_descendant_ids

    @adverts = Advert.where(category_id: ids).order(created_at: :desc)
  end

  def new
    @advert = Advert.new
    @categories = Category.hash_tree
  end

  def new_ad_form
    category = Category.find(advert_category_param[:category_id])
    @advert = Advert.new
    @advert.category = category
    @fieldsdef = category.self_and_ancestors.map {|p| p.fields}.inject {|a,b| a.merge!(b)}
  end

  def create
    @advert = Advert.new(advert_form_params)
    if @advert.save
        redirect_to edit_gallery_path(@advert), notice: "Advert successfully created."
    else
        @fieldsdef = @advert.category.self_and_ancestors.map {|p| p.fields}.inject {|a,b| a.merge!(b)}
        render action: 'new_ad_form'
    end
  end

  def show
    @advert = Advert.find(params[:id])
    @images = @advert.uploads
    @breadcrumb = @advert.category.ancestors.reverse + [@advert.category]
  end

  def edit
    @advert = Advert.find(params[:id])
    @fieldsdef = @advert.category.self_and_ancestors.map {|p| p.fields}.inject {|a,b| a.merge!(b)}
  end

  def update
    @advert = Advert.find(params[:id])
    if @advert.update_attributes(advert_form_params)
      redirect_to show_advert_path(@advert), notice: "Advert successfully updated."
    else
      @fieldsdef = @advert.category.self_and_ancestors.map {|p| p.fields}.inject {|a,b| a.merge!(b)}
      render action: 'edit'
    end
  end

  def destroy
    advert = Advert.find(params[:id])

    advert.delete
    redirect_to adverts_path, notice: "'Advert #{advert.title}' removed."
  end

  def edit_gallery
    @advert = Advert.find(params[:id])
    @uploads = Upload.where(advert_id: params[:id])
    @new_upload = Upload.new
    @new_upload.advert = @advert
  end

  def upload_to_gallery
    @upload = Upload.new(upload_params)
    if @upload.save
      redirect_to edit_gallery_path(@upload.advert), notice: 'Image Uploaded!'
    else
      redirect_to edit_gallery_path(@upload.advert), alert: "Upload Failed. #{get_error_string(@upload)}"
    end
  end

  private

    def advert_category_param
      params.require(:advert).permit(:category_id)
    end

    def advert_form_params
      r = params.require(:advert).permit(:title, :description, :fieldvalues, :category_id, :price, :price_type)
      r['fieldvalues'] = JSON.parse(r['fieldvalues'])
      return r
    end

    def upload_params
      params.require(:upload).permit(:image, :advert_id)
    end

    def get_error_string(obj)
      obj.errors.map {|a, e| "#{a} : #{e}. "}.join
    end
end
