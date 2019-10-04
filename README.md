# README
Create Rails API only application
Add default format as Json
Remove view related gems in the gemfile
Added few gems for handling some format, 
kaminari - pagination, 
svy21 - for convert SVY21 format to latitude and longitude, 
geokit-rails - Used for finding available car parks within range, 
Jbuilder - Json formatter, 
Create migration for storing car park information, 
Added routes, controller for car parking, 

Rake Task:
create a rake task for upload csv and update live car parking available lots etc
rake carpark:upload -> uploading data from carpark_information.csv file and convert svy21 to latitude & longitude
rake carpark:update -> this task fetch live data from available car parks information and updated available lots and total lots based car park number

Controller:
Add nearest action in the carparkscontroller
Validate the request have latitude and longitute.
If not send 400 error response
Else, fetching car parks within range based on available lots greater than Zero and sort the car parks based on total lots.
Handling the data based on Pagination & Construct JSON format

Model
Create CarPark model and migration
Add validation for latitude, longitude, car park num
