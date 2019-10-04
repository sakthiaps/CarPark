require 'csv'

namespace :carpark do
  desc "Starting to upload carpark"

  task :upload => :environment do

    car_parking_details = CSV.parse(File.read("hdb-carpark-information.csv"), headers: true)

    car_parking_details.each do |car_parking_detail|

      car_park = CarPark.find_by(:car_park_no => car_parking_detail["car_park_no"])
      next if car_park.present?

      attr = {
       :car_park_no => car_parking_detail["car_park_no"],
       :address => car_parking_detail["address"],
      }
      # car_park[:car_park_no] = car_parking_detail["car_park_no"]
      # car_park[:address] = car_parking_detail["address"]
      lat_lon = SVY21.svy21_to_lat_lon(car_parking_detail["x_coord"].to_f, car_parking_detail["y_coord"].to_f)
      attr[:latitude] = lat_lon[0]
      attr[:longitude] = lat_lon[1]
      # car_park[:latitude] = lat_lon[0]
      # car_park[:longitude] = lat_lon[1]
      car_park = CarPark.new(attr)
      car_park.save
    end
    puts "Upload completed"
  end

  task :update => :environment do
    url = "https://api.data.gov.sg/v1/transport/carpark-availability?date_time=#{Time.now.strftime("%Y-%m-%dT%I:%M:%S")}"
    response = HTTParty.get(url)

    response["items"].each do |item_hash|
      carpark_data = item_hash["carpark_data"]

      carpark_data.each do |carpark_hash|
        car_park = CarPark.find_by(:car_park_no => carpark_hash["carpark_number"])
        next if car_park.blank?

        carpark_info = carpark_hash["carpark_info"].first
        car_park.update_attributes(:total_lots => carpark_info["total_lots"], :available_lots => carpark_info["lots_available"])
      end
    end
    puts "Process completed"
  end

end