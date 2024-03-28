if [ $(cat .env | grep "key" | wc -l) -eq 0 ]; then
    echo "Enter the api key"
    read api_key
    echo "\nkey=$api_key" >> .env
    
    api_key=$(cat .env | grep "key" | cut -d "=" -f 2)
    latitude=$(cat .env | grep "LATITUDE" | cut -d "=" -f 2)
    longitude=$(cat .env | grep "LONGITUDE" | cut -d "=" -f 2)

else
    api_key=$(cat .env | grep "key" | cut -d "=" -f 2)
    latitude=$(cat .env | grep "LATITUDE" | cut -d "=" -f 2)
    longitude=$(cat .env | grep "LONGITUDE" | cut -d "=" -f 2)
fi

echo "Paris Weather Report"
curl -s "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$api_key" | \
jq -r '.weather[0].description, .main.temp_max, .main.temp_min, .main.feels_like, .main.humidity, .main.pressure, .wind.speed, .wind.deg, .visibility, .sys.sunrise, .sys.sunset' | \
awk 'NR==1 {print "Description: " $0} 
     NR==2 {print "Maximum Temperature: " $0 " °F"} 
     NR==3 {print "Minimum Temperature: " $0 " °F"} 
     NR==4 {print "Feels like: " $0 " °F"} 
     NR==5 {print "Humidity: " $0 "%"} 
     NR==6 {print "Pressure: " $0 " hPa"} 
     NR==7 {print "Wind Speed: " $0 " m/s"} 
     NR==8 {print "Wind Degree: " $0 "°"} 
     NR==9 {print "Visibility: " $0 " m"} 
     NR==10 {print "Sunrise: " strftime("%H:%M", $0)} 
     NR==11 {print "Sunset: " strftime("%H:%M", $0)}'