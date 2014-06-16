class UploadsController < ApplicationController

  def index
    @uploads = Upload.all
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    if @upload.save
      redirect_to show_upload_path(@upload), notice: 'Upload uploaded'
    else
      render action: 'new'
    end
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(edit_upload_params)
      redirect_to edit_gallery_path(@upload.advert), notice: "a"
    else
      render action: 'edit'
    end
  end

  def show
    @upload = Upload.find(params[:id])
  end

  private
    def upload_params
      params.require(:upload).permit(:image, :advert_id)
    end

    def edit_upload_params
      params.require(:upload).permit(:description)
    end
end
