json.array! @car_parks do |carpark|
  json.address carpark.address
  json.latitude carpark.latitude
  json.longitude carpark.longitude
  json.total_lots carpark.total_lots
  json.available_lots carpark.available_lots
end
