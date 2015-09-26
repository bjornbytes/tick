local tick = {
  framerate = -1,
  tickrate = .03,
  timescale = 1,
  sleep = .001,
  dt = 0,
  accum = 0,
  tick = 1,
  frame = 1
}

local timer = love.timer
local graphics = love.graphics

love.run = function()
  if love.math then
    love.math.setRandomSeed(os.time())
    for i = 1, 3 do love.math.random() end
  end

  if love.event then love.event.pump() end
  if love.load then love.load(arg) end
  timer.step()
  local lastframe = 0

  while true do
    timer.step()
    tick.dt = timer.getDelta() * tick.timescale
    tick.accum = tick.accum + tick.dt
    while tick.accum >= tick.tickrate do
      tick.accum = tick.accum - tick.tickrate

      if love.event then
        love.event.pump()
        for e, a, b, c, d in love.event.poll() do
          if e == 'quit' then
            if not love.quit or not love.quit() then
              if love.audio then love.audio.stop() end
              return
            end
          end

          love.handlers[e](a, b, c, d)
        end
      end

      tick.tick = tick.tick + 1
      if love.update then love.update(tick.tickrate) end
    end

    while timer.getTime() - lastframe < 1 / tick.framerate do
      timer.sleep(.0005)
    end

    lastframe = timer.getTime()
    if graphics and love.window and love.window.isCreated() then
      graphics.clear()
      graphics.origin()
      tick.frame = tick.frame + 1
      if love.draw then love.draw() end
      graphics.present()
    end

    timer.sleep(tick.sleep)
  end
end

return tick
