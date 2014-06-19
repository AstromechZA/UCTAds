class UploadsController < ApplicationController

  def edit
    @upload = Upload.find(params[:id])
  end

  def show
    @upload = Upload.find(params[:id])
  end

  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(edit_upload_params)
      redirect_to edit_gallery_path(@upload.advert), notice: "Updated description of image."
    else
      render action: 'edit'
    end
  end

  def destroy
    upload = Upload.find(params[:id])
    upload.delete
    redirect_to edit_gallery_path(upload.advert), notice: "Image removed."
  end

  private
    def edit_upload_params
      params.require(:upload).permit(:description)
    end
end
