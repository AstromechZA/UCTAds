class UploadsController < ApplicationController

  def index
    @uploads = Upload.all
  end

  def show
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.create(upload_params)
  end

  private
    def upload_params
      params[:upload].permit(:image)
    end
end
