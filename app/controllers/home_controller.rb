class HomeController < ApplicationController
  helper_method :images

  def index
    @image = Image.new
  end

  def screenshot
    @image = Image.create(params[:image])
    render :index
  end

  private

  def images
    @images ||= Image.last
  end

end
