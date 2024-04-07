#!/bin/sh

echo "Weather Report : LATITUDE: $LAT | LONGITUDE: $LONG"
busybox wget -qO- "http://api.openweathermap.org/data/2.5/weather?lat=$LAT&lon=$LONG&appid=$API_KEY" | \
busybox awk '
    BEGIN { RS="[,{}]"; FS=":"; }
    /description/ { gsub(/"/, "", $2); description = $2 }
    /temp_max/ { gsub(/"/, "", $2); temp_max = $2 }
    /temp_min/ { gsub(/"/, "", $2); temp_min = $2 }
    /feels_like/ { gsub(/"/, "", $2); feels_like = $2 }
    /humidity/ { gsub(/"/, "", $2); humidity = $2 }
    /pressure/ { gsub(/"/, "", $2); pressure = $2 }
    /speed/ { gsub(/"/, "", $2); speed = $2 }
    /deg/ { gsub(/"/, "", $2); deg = $2 }
    /visibility/ { gsub(/"/, "", $2); visibility = $2 }
    /sunrise/ { gsub(/"/, "", $2); sunrise = $2 }
    /sunset/ { gsub(/"/, "", $2); sunset = $2 }
    END {
        print "Description: " description
        print "Maximum Temperature: " temp_max " °F"
        print "Minimum Temperature: " temp_min " °F"
        print "Feels like: " feels_like " °F"
        print "Humidity: " humidity "%"
        print "Pressure: " pressure " hPa"
        print "Wind Speed: " speed " m/s"
        print "Wind Degree: " deg "°"
        print "Visibility: " visibility " m"
        print "Sunrise: " strftime("%H:%M", sunrise)
        print "Sunset: " strftime("%H:%M", sunset)
    }'
