class CarparksController < ApplicationController

  PER_PAGE = 3

  def nearest
    if params[:latitude].blank? || params[:longitude].blank?
      render status: 400, json: {message: "Required params missing"}.to_json
      return
    end

    params.require(:latitude)
    params.require(:longitude)

    @car_parks = CarPark.within(0.2, :units => :miles, :origin => [params[:latitude], params[:longitude]])
                .where("car_parks.available_lots > 0").order("car_parks.total_lots desc")

    @car_parks = @car_parks.page(page_from_params).per(params[:per_page] || PER_PAGE)
  end
end
