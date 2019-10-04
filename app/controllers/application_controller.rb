class ApplicationController < ActionController::API

  def page_from_params
    @page = params[:page] = [params[:page].to_i, 1].max
  end

end
