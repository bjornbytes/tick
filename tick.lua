--[[
  Copyright (c) 2015 Bjorn Swenson

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
]]
local tick = {
  framerate = nil,
  rate = .03,
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
  if not timer then
    error('love.timer is required for tick')
  end

  if love.load then love.load(love.arg.parseGameArguments(arg), arg) end
  timer.step()
  local lastframe = 0

  love.update(0)

  return function()
    tick.dt = timer.step() * tick.timescale
    tick.accum = tick.accum + tick.dt
    while tick.accum >= tick.rate do
      tick.accum = tick.accum - tick.rate

      if love.event then
        love.event.pump()
        for name, a, b, c, d, e, f in love.event.poll() do
          if name == 'quit' then
            if not love.quit or not love.quit() then
              return a or 0
            end
          end

          love.handlers[name](a, b, c, d, e, f)
        end
      end

      tick.tick = tick.tick + 1
      if love.update then love.update(tick.rate) end
    end

    while tick.framerate and timer.getTime() - lastframe < 1 / tick.framerate do
      timer.sleep(.0005)
    end

    lastframe = timer.getTime()
    if graphics and graphics.isActive() then
      graphics.origin()
      graphics.clear(graphics.getBackgroundColor())
      tick.frame = tick.frame + 1
      if love.draw then love.draw() end
      graphics.present()
    end

    timer.sleep(tick.sleep)
  end
end

return tick
