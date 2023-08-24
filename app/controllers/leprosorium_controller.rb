class LeprosoriumController < ApplicationController
  # helper LeprosoriumHelper

  def entities
    render json: Leprosorium.entities.as_json
  end

  def index; end

  def markup
    @text = params[:text]
    @result = DisclaimerMarker.new.call(params[:text])
    render :index
  end
end
