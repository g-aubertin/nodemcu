function wifi_stat ()
  if wifi.sta.getip() == nil then
    print("IP unavaiable, Waiting...")
  else
    print("ESP8266 mode is: " .. wifi.getmode())
    print("The module MAC address is: " .. wifi.ap.getmac())
    print("Config done, IP is "..wifi.sta.getip())
    mytimer:stop()
  end
end

-- main

wifi.setmode(wifi.STATION)

station_cfg={}
station_cfg.ssid="une-bonne-biere"
station_cfg.pwd="cracotte2008"
station_cfg.save=false
wifi.sta.config(station_cfg)
wifi.sta.connect()

mytimer = tmr.create()
mytimer:register(1000, tmr.ALARM_AUTO, wifi_stat)
mytimer:start()

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
   conn:on("receive",function(conn,payload)
      print(payload)
      status, temp, humi, temp_dec, humi_dec = dht.read(2)
      conn:send(string.format("<h1> temperature : %d, humidity : %d</h1>", math.floor(temp), math.floor(humi)))

   end)
end)