class LeprosoriumController < ApplicationController
  def index; end

  def markup
    @text = params[:text]
    @result = DisclaimerMarker.new.call(params[:text])
    render :index
  end
end
