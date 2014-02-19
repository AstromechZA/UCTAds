class AdvertsController < ApplicationController

  def index
    @adverts = Advert.all
  end

  def new
    @advert = Advert.new
    @categories = Category.hash_tree
  end

  def new_ad_form
    @category = Category.find(advert_category_param[:category_id])
    @advert = Advert.new
    @advert.category = @category
  end

  def create
    advert = Category.new(advert_form_params)
    if advert.save
        redirect_to advert
    else
        render action: 'new_ad_form'
    end
  end

  private

    def advert_category_param
      params.require(:category).permit(:category_id)
    end

    def advert_form_params
      params.require(:category).permit(:title, :description, :fieldvalues, :category_id)
    end

end
