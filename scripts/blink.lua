-- LED test
-- GPIO2 -> pin 4

local pin = 4
local value = gpio.LOW
local duration = 1000

function blink ()
  if value == gpio.LOW then
    value = gpio.HIGH
  else
    value = gpio.LOW
  end

  gpio.write(pin, value)
end

-- main

gpio.mode(pin, gpio.OUTPUT)
gpio.write(pin, value)

local mytimer = tmr.create()
mytimer:register(1000, tmr.ALARM_AUTO, blink)
mytimer:start()
