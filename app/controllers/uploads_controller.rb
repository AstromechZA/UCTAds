class UploadsController < ApplicationController

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
    def edit_upload_params
      params.require(:upload).permit(:description)
    end
end
