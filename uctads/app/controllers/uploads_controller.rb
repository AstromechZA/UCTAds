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
      redirect_to @upload, notice: 'Upload uploaded'
    else

      render action: 'new'
    end
  end

  def show
    @upload = Upload.find(params[:id])
  end

  private
    def upload_params
      params.require(:upload).permit(:image)
    end
end
