local ls = {
  framerate = -1,
  tickrate = .03,
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
    ls.dt = timer.getDelta()
    ls.accum = ls.accum + ls.dt
    while ls.accum >= ls.tickrate do
      ls.accum = ls.accum - ls.tickrate

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

      ls.tick = ls.tick + 1
      if love.update then love.update(ls.tickrate) end
    end

    while timer.getTime() - lastframe < 1 / ls.framerate do
      timer.sleep(.0005)
    end

    lastframe = timer.getTime()
    if graphics and love.window and love.window.isCreated() then
      graphics.clear()
      graphics.origin()
      ls.frame = ls.frame + 1
      if love.draw then love.draw() end
      graphics.present()
    end

    timer.sleep(ls.sleep)
  end
end

return ls
